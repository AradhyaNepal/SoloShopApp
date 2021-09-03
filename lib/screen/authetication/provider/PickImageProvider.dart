import 'package:flutter/cupertino.dart';
import 'dart:io';

class PickImageProvider with ChangeNotifier{
  File? _pickedImage;

  void updatingImage(File? image){
    _pickedImage=image;
    notifyListeners();

  }

  bool doImageExist()=>_pickedImage!=null;

  File? get pickedImage=>_pickedImage;

  void refresh(){
    _pickedImage=null;
    notifyListeners();
  }


}