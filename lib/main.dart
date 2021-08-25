import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/screen/orders_detail/page/OrdersPage.dart';
import 'package:solo_shop_app_practice/screen/orders_detail/providers/OrderProvider.dart';
import 'package:solo_shop_app_practice/screen/product_cart/page/CartPage.dart';
import 'package:solo_shop_app_practice/screen/product_cart/providers/CartProvider.dart';
import 'package:solo_shop_app_practice/screen/products_overview/providers/ProductsProvider.dart';
import 'package:solo_shop_app_practice/screen/product_detail/page/ProductDetails.dart';
import 'package:solo_shop_app_practice/screen/products_overview/page/ProductsOverview.dart';
import 'package:provider/provider.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
           create: (context)=>ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context)=>CartProvider(),
        ),
        ChangeNotifierProvider(
            create: (context)=>OrderProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        initialRoute: ProductsOverview.route,
        routes: {
          ProductsOverview.route:(context)=>ProductsOverview(),
          ProductDetails.route:(context)=>ProductDetails(),
          CartPage.route:(context)=>CartPage(),
          OrderPage.route:(context)=>OrderPage(),
        },
      ),
    );
  }
}
