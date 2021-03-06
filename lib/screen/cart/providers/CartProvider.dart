import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/models/Cart.dart';

class CartProvider with ChangeNotifier{
  Map<String,Cart> _items={};

  Map<String,Cart> get items{
    return {..._items};
  }

  void addItem(String productId,double price,String title){
      if (_items.containsKey(productId)){
        _items.update(productId, (oldCart) => Cart(id: oldCart.id,title: oldCart.title,price: oldCart.price,quantity: oldCart.quantity+1));


      }
      else{
        _items.putIfAbsent(productId, ()=>Cart(id:Cart.uniqueId,title: title,price: price,quantity: 1));
      }
      notifyListeners();
  }

  String get length=>_items.length.toString();

  double get totalAmount{
    double total=0.0;
    _items.forEach((key, cart) {
      total=cart.price*cart.quantity+total;
    });
    return total;
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items.clear();
    notifyListeners();
  }

  void removeSingleItem(String productId){
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity>1){
      _items.update(productId, (oldCart) => Cart(
          id: oldCart.id,
          title: oldCart.title,
          quantity: oldCart.quantity-1,
          price: oldCart.price)
      );
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }
}