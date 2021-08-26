import 'package:flutter/cupertino.dart';
import 'package:solo_shop_app_practice/models/Cart.dart';
import 'package:solo_shop_app_practice/models/Order.dart';

class OrderProvider with ChangeNotifier{

  List<Order> _orders=[];

  List<Order> get orders{
    return [..._orders];
  }

  void addOrder({required List<Cart> cartProducts,required double total}){
    _orders.insert(0, Order(
        id: Order.uniqueId,
        amount:total ,
        products: cartProducts,
        dateTime: DateTime.now(),
    ));

    notifyListeners();
  }
}