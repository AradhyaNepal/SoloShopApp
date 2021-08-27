import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier{
  bool _isLoading=false;


  void setDefault(){
    _isLoading=false;
  }

  void toggleLoading(){
    _isLoading=!_isLoading;
    notifyListeners();
  }

  bool getLoading(){
    return _isLoading;

  }
}