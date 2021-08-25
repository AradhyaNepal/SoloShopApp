import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/ManageProduct.dart';
import 'package:solo_shop_app_practice/screen/orders_detail/page/OrdersPage.dart';
import '../../screen/products_overview/page/ProductsOverview.dart';
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
