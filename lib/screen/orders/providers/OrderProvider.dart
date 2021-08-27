import 'package:flutter/cupertino.dart';
import 'package:solo_shop_app_practice/models/Cart.dart';
import 'package:solo_shop_app_practice/models/Order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OrderProvider with ChangeNotifier{

  final String authToken;
  final String userId;
  OrderProvider(this.authToken,this.userId);
  List<Order> _orders=[];

  List<Order> get orders{
    return [..._orders];
  }

  Future<void> fetchOrder() async{
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response=await http.get(url);
    final List<Order> loadedOrders=[];
    final Map<String,dynamic>? extractedData=json.decode(response.body) as Map<String,dynamic>;
    if (extractedData==null) return;
    extractedData.forEach((key, value) {
      loadedOrders.add(Order(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>).map((item)=>Cart(
              id: item['id'],
              title: item['price'],
              quantity: item['qunatity'],
              price: item['price']
          )

          ).toList(),
          dateTime: DateTime.parse(value['dateTime']),
          ));
    });
    _orders=loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder({required List<Cart> cartProducts,required double total}) async{
    Uri url=Uri.parse('https://fir-practice-fff91.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timeStamp=DateTime.now();
    final response=await http.post(url,body: json.encode({
      'amount':total,
      'dateTime':timeStamp.toIso8601String(),
      'products':cartProducts.map((e) => {
        'id':e.id,
        'title':e.title,
        'quantity':e.quantity,
        'price':e.price,
      }),

    }));
    _orders.insert(0, Order(
        id: json.decode(response.body)['name'],
        amount:total ,
        products: cartProducts,
        dateTime: timeStamp,
    ));

    notifyListeners();
  }
}