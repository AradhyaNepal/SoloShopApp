
import 'package:flutter/cupertino.dart';
import 'package:solo_shop_app_practice/models/Product.dart';

class ProductsProvider with ChangeNotifier{
  List<Product> _items=[
    Product(
    id: 'p1',
    title: 'Red Shirt 1',
    description: 'A red shirt - It is pretty red',
    price: 29.99,
    imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',

  ),
    Product(
      id: 'p2',
      title: 'Red Shirt 2',
      description: 'A red shirt - It is pretty red',
      price: 29.99,
      imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',

    ),
    Product(
      id: 'p3',
      title: 'Red Shirt 3',
      description: 'A red shirt - It is pretty red',
      price: 29.99,
      imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',

    ),
    Product(
      id: 'p4',
      title: 'Red Shirt 4',
      description: 'A red shirt - It is pretty red',
      price: 29.99,
      imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',

    )];


  List<Product> get favItems =>_items.where((product)=>product.isFavorite,).toList();

  List<Product> get items=>[..._items];



}