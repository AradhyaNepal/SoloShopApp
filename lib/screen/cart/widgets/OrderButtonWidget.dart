import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/cart/providers/CartProvider.dart';
import 'package:solo_shop_app_practice/screen/orders/providers/OrderProvider.dart';

class OrderButtonWidget extends StatefulWidget {
  @override
  _OrderButtonWidgetState createState() => _OrderButtonWidgetState();
}

class _OrderButtonWidgetState extends State<OrderButtonWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final cartProvider=Provider.of<CartProvider>(context);
    return TextButton(
        onPressed:(cartProvider.totalAmount<=0 || isLoading) ?
        null:
            () async{
          setState(() {
            isLoading=true;
          });
          await Provider.of<OrderProvider>(context,listen: false).addOrder(
              cartProducts:cartProvider.items.values.toList(),
              total:cartProvider.totalAmount);
          setState(() {
            isLoading=false;
          });
          cartProvider.clear();

        },
        child:isLoading?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ordering...'),
            CircularProgressIndicator(),
          ],
        )
            : Text(
            'Order'
        )
    );
  }
}
