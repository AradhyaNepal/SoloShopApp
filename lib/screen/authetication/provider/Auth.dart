import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_shop_app_practice/models/HttpException.dart';
class Auth with ChangeNotifier{
   String? _token;
   DateTime? _expiryDate;
   String? _userId;
   Timer? _authTimer;

  bool get isAuth{
    return token!=null;
  }

  String? get token{
    if (_expiryDate !=null && _expiryDate!.isAfter(DateTime.now()) && _token !=null){
      return _token;
    }
    return null;
  }
  Future<void> signUp(String email,String password,String url) async{
    return authenticate(email, password, 'signUp').then((value) {
      FirebaseFirestore.instance.collection('users').doc(json.decode(value.body.toString())['localId']).set({
        'profile':url,
      });
    });

  }


  String? get userId=>_userId;

  Future<void> login(String email,String password) async{
   return authenticate(email, password, 'signInWithPassword').then((value) async{
     final responseData=json.decode(value.body.toString());
     if (responseData['error'] != null){
       print('I was here');
       throw HttpException(responseData['error']['message']);
     }

     _token=responseData['idToken'];
     _userId=responseData['localId'];
     _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
     notifyListeners();
     final prefs=await SharedPreferences.getInstance();
     prefs.setString('userData',json.encode({
       'userId':_userId,
       'token':_token,
       'expiryDate':_expiryDate!.toIso8601String(),
     }));
   });



  }



  Future<bool> tryAutoLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    String? prefsData=prefs.getString('userData');
    final userData = json.decode(prefsData!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = userData['token'] as String;
    _userId = userData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<http.Response> authenticate(String email,String password,String uses) async{
    Uri uri=Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$uses?key=AIzaSyC2hz_OpmfV0KQSnZDNiKBrGmV3pM0MaAE');
    try{
      Response response=await http.post(uri,body: json.encode({
        'email':email,
        'password':password,
        'returnSecureToken':true,
      }));
      return response;

    }catch(error){
      print(error);
      throw error;
    }

  }


  Future<void> logOut() async{
    if (_authTimer!=null){
      _authTimer!.cancel();
      _authTimer=null;
    }
    _token=null;
    _userId=null;
    _expiryDate=null;
    notifyListeners();
    final prefs=await SharedPreferences.getInstance();
    prefs.clear();
  }


  void autoLogout(){
    if (_authTimer!=null){
      _authTimer!.cancel();
    }
    final timeToExpiry=_expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(Duration(seconds:timeToExpiry ),(){
      logOut();
    });
  }

}