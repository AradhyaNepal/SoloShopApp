import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:solo_shop_app_practice/models/HttpException.dart';
class Auth with ChangeNotifier{
  late String _token;
  late DateTime _expiryDate;
  late String _userId;
  Timer _authTimer;

  bool get isAuth{
    return token!=null;
  }

  String? get token{
    if (_expiryDate !=null && _expiryDate.isAfter(DateTime.now()) && _token !=null){
      return _token;
    }
    return null;
  }
  Future<void> signUp(String email,String password) async{
    return authenticate(email, password, 'signUp');

  }


  String get userId=>_userId;

  Future<void> login(String email,String password) async{
   return authenticate(email, password, 'signInWithPassword');

  }

  Future<void> authenticate(String email,String password,String uses) async{

    //this url must be changed
    Uri uri=Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$uses?key=AIzaSyC2hz_OpmfV0KQSnZDNiKBrGmV3pM0MaAE');
    try{
      final response=http.post(uri,body: json.encode({
        'email':email,
        'password':password,
        'returnSecureToken':true,

      }));
      final responseData=json.decode(response.toString());//Error
      if (responseData['error'] != null){
        throw HttpException(responseData['error']['message']);
      }

      _token=responseData['idToken'];
      _userId=responseData['localId'];
      _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      autoLogout();
      notifyListeners();
    }catch(error){
      throw error;
    }

  }


  void logOut(){
    if (_authTimer!=null){
      _authTimer.cancel();
      _authTimer=null;
    }
    _token=null;
    _userId=null;
    _expiryDate=null;


    notifyListeners();
  }


  void autoLogout(){
    if (_authTimer!=null){
      _authTimer.cancel();
    }
    final timeToExpiry=_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(Duration(seconds:timeToExpiry ),(){
      logOut();
    });
  }

}