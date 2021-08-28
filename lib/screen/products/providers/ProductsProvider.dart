
import 'package:flutter/cupertino.dart';
import 'package:solo_shop_app_practice/models/HttpException.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier{
  //Add auth in orders and products later
  String? authToken;
  String? userId;
  ProductsProvider(this.authToken,this._items,this.userId);
  List<Product> _items=[];


  List<Product> get favItems =>_items.where((product)=>product.isFavorite,).toList();

  List<Product> get items=>[..._items];



  Future<void> addProduct(Product product){
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/products.json?auth=$authToken');
    return http.post(url,body:json.encode({
      'title':product.title,
      'description':product.description,
      'imageUrl':product.imageUrl,
      'price':product.price,
      'createrId':userId,
    })).then((value) {
      product.id=json.decode(value.body).toString();
        _items.add(product);
        notifyListeners();

    }).catchError((error){
      throw error;
    }
    );
  }

  Future<void> fetchProduct([bool filterByUser=false]) async{//[optional but need default value]
    final filterString=filterByUser?'orderBy="createrId"&equalTo="$userId"':'';
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/products.json?auth=$authToken&$filterString');

    try{
      final response=await http.get(url);
      final extractedData=json.decode(response.body) as Map<String,dynamic>;
      //is null check, and there is error in this url
      url=Uri.parse('https://fir-practice-fff91.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse=await http.get(url);
      final favoriteData=json.decode(favoriteResponse.body);
      final List<Product> loadedProduct=[];
      extractedData.forEach((key, value) {
        loadedProduct.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'] as double,
            isFavorite: favoriteData==null?false:favoriteData[key] as bool? ?? false, // ?? check null
            imageUrl:value['imageUrl']
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