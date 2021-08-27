import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/cart/page/CartPage.dart';
import 'package:solo_shop_app_practice/screen/cart/providers/CartProvider.dart';
class CartMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String length=Provider.of<CartProvider>(context).length;
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, CartPage.route);
      },
      child: Container(
        height: 30,
        width: 30,
        child: Stack(
          children: [
            Positioned.fill(
                child: Icon(Icons.shopping_cart_sharp),
            ),
            Positioned(

              top: 0,
              right: 0,
              child: length=='0'?SizedBox():
              Container(
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),

                  child: Text(
                      length,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
