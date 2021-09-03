import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/common/Widgets/DrawerWidget.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/Auth.dart';

class ProfilePage extends StatefulWidget {
  static String route='ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? url;
  @override
  Widget build(BuildContext context) {
    getUrl();
    return Scaffold(
      body: Center(child:url==null?CircularProgressIndicator():CircleAvatar(

                  backgroundImage: NetworkImage(url!),
                  radius: 60,
                )
            )
    );



  }


  void getUrl(){
    FirebaseFirestore.instance.collection('users').doc(Provider.of<Auth>(context).userId).snapshots().listen((event) {
      setState(() {

        url=event['profile'];
      });
    }).onError((error){
      setState(() {

        url='https://www.computerhope.com/jargon/e/error.png';
      });
    });



  }
}
