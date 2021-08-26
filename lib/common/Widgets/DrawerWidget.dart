import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/screen/orders/page/OrdersPage.dart';
import 'package:solo_shop_app_practice/screen/products/page/ProductsOverview.dart';
import '../../screen/products/page/ManageProduct.dart';
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Navigator.pushReplacementNamed(context,ProductsOverview.route);
            },

          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (){
              Navigator.pushReplacementNamed(context,OrderPage.route);
            },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.sixteen_mp),
            title: Text('Manage Product'),
            onTap: (){
              Navigator.pushReplacementNamed(context,ManageProduct.route);
            },

          )
        ],
      ),
    );
  }
}
