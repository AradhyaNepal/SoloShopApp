
import 'package:flutter/cupertino.dart';


class Product with ChangeNotifier{
  final String id;
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

  void toggleFavorites(){
    isFavorite=!isFavorite;
    notifyListeners();
  }
}