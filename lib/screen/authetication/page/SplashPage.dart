import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const route='splashPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:Center(
            child: Column(
              children: [
                Text('Shop App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
                CircularProgressIndicator(),
              ],
            )
          )
      ),
    );
  }
}
