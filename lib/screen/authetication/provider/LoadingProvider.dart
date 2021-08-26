import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier{
  bool _isLoading=false;



  void toggleLoading(){
    print('I was here: $_isLoading');
    _isLoading=!_isLoading;
    print('I was here: $_isLoading');
    notifyListeners();
  }

  bool getLoading(){
    return _isLoading;

  }
}