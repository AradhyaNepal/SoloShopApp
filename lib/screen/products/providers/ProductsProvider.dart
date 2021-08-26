
import 'package:flutter/cupertino.dart';
import 'package:solo_shop_app_practice/models/HttpException.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier{
  //Add auth in orders and products later
  final String authToken;
  ProductsProvider(this.authToken,this._items);
  List<Product> _items=[
  //   Product(
  //   id: 'p1',
  //   title: 'Red Shirt 1',
  //   description: 'A red shirt - It is pretty red',
  //   price: 29.99,
  //   imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',
  //
  // ),
  //   Product(
  //     id: 'p2',
  //     title: 'Red Shirt 2',
  //     description: 'A red shirt - It is pretty red',
  //     price: 29.99,
  //     imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',
  //
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Red Shirt 3',
  //     description: 'A red shirt - It is pretty red',
  //     price: 29.99,
  //     imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',
  //
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'Red Shirt 4',
  //     description: 'A red shirt - It is pretty red',
  //     price: 29.99,
  //     imageUrl: 'https://static-01.daraz.com.np/p/3b17b441784d55f7fafe494c2b3ae4c0.jpg',

    // )
  ];


  List<Product> get favItems =>_items.where((product)=>product.isFavorite,).toList();

  List<Product> get items=>[..._items];



  Future<void> addProduct(Product product){
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/products.json?auth=$authToken');
    return http.post(url,body:json.encode({
      'title':product.title,
      'description':product.description,
      'imageUrl':product.imageUrl,
      'price':product.price,
      'isFavorite':product.isFavorite,
    })).then((value) {
      product.id=json.decode(value.body).toString();
        _items.add(product);
        notifyListeners();

    }).catchError((error){
      throw error;
    }
    );
  }

  Future<void> fetchProduct() async{
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/products.json?auth=$authToken');
    try{
      final response=await http.get(url);
      final extractedData=json.decode(response.body) as Map<String,dynamic>;
      final List<Product> loadedProduct=[];
      extractedData.forEach((key, value) {
        loadedProduct.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl:value['imageUrl'],
          isFavorite: value['isFavorite']
        ));
      });

      _items=loadedProduct;
      notifyListeners();


    }catch(error){
      throw error;

    }
  }

  Product findById(String id){
    return _items.firstWhere((element)=>element.id==id);


  }

  Future<void> updateProduct(String id,Product newProduct) async{
    final productIndex=_items.indexWhere((element) => element.id==id);
    if (productIndex>=0){

      Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,body: json.encode({
        'title':newProduct.title,
        'description':newProduct.description,
        'imageUrl':newProduct.imageUrl,
        'price':newProduct.price,
      }));
      _items[productIndex]=newProduct;
      notifyListeners();

    }
  }

  Future<void> deleteProduct(String id) async{
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/products/$id.json?auth=$authToken');
    int? existingProductIndex=items.indexWhere((element) => element.id==id);
    Product? existingProduct=_items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response=await http.delete(url);
    if(response.statusCode>=400){
      _items.insert(existingProductIndex,existingProduct);
      notifyListeners();
      throw HttpException('Error'); //throw is like return which closes this functino
    }
    existingProductIndex=null;
    existingProduct=null;

  }


}