import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/models/Cart.dart';
import 'package:solo_shop_app_practice/screen/orders_detail/providers/OrderProvider.dart';
import 'package:solo_shop_app_practice/screen/product_cart/providers/CartProvider.dart';
import 'package:solo_shop_app_practice/screen/product_cart/widgets/CartWidget.dart';

class CartPage extends StatelessWidget {
  static const route='/CartPage';
  @override
  Widget build(BuildContext context) {
    final cartProvider=Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
        Card(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                  'Total',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10,),
              Chip(
                label: Text(
                  cartProvider.totalAmount.toString(),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              TextButton(onPressed:(){
                Provider.of<OrderProvider>(context,listen: false).addOrder(
                    cartProducts:cartProvider.items.values.toList(),
                    total:cartProvider.totalAmount);
                cartProvider.clear();

              },
                  child: Text(
                      'Order'
                  )),
            ],
          ),
        ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemBuilder:(context,i){
                  Map<String,Cart> cartMap= cartProvider.items;
                  Cart cart=cartMap.values.toList()[i];
                  return CartWidget(
                      id: cart.id,
                      title: cart.title,
                      price: cart.price,
                      productId: cartMap.keys.toList()[i],
                      quantity: cart.quantity);


    },
              itemCount: cartProvider.items.length,
            ),
          )

      ],),
    );
  }
}
