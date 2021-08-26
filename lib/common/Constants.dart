import 'package:flutter/material.dart';

class Constants{
  bool passwordVisible=false;
  InputDecoration getInputDecoration(String labelText,{passwordMode=false}){
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      icon: passwordMode?IconButton(
          onPressed: (){
            passwordVisible=!passwordVisible;
          },
          icon: passwordVisible?Icon(Icons.visibility_off):Icon(Icons.visibility)
      ):null,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.blue),

      ),
    );
  }
}