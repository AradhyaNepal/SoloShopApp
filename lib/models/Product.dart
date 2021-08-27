
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;
  Product(
  {
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite=false,
  }
  );

  void toggleFavorites(String token,String userId) async{
    bool oldStatus=isFavorite;
    isFavorite=!isFavorite;
    notifyListeners();
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/userFavorites/$userId/$id.json');
    try{
      final response=await http.put(url,body: json.encode(
        isFavorite,
      ));

      if (response.statusCode>=400){
        isFavorite=oldStatus;
        notifyListeners();
      }
    }catch(error){
      isFavorite=oldStatus;
      notifyListeners();
    }

  }
}