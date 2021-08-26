import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/SignInPage.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/SignUpPage.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/AlternativeAuthenticationClass.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/Auth.dart';
import 'package:solo_shop_app_practice/screen/cart/page/CartPage.dart';
import 'package:solo_shop_app_practice/screen/cart/providers/CartProvider.dart';
import 'package:solo_shop_app_practice/screen/orders/page/OrdersPage.dart';
import 'package:solo_shop_app_practice/screen/orders/providers/OrderProvider.dart';
import 'package:solo_shop_app_practice/screen/products/page/ProductsOverview.dart';
import 'screen/products/page/ManageProduct.dart';
import 'screen/products/page/EditProduct.dart';
import 'screen/products/page/ProductDetails.dart';
import 'package:provider/provider.dart';

import 'screen/products/providers/ProductsProvider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,ProductsProvider>(
           update:(context,auth,previousProducts)=>ProductsProvider(auth.token,
               previousProducts == null?[]:previousProducts.items),
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
          ManageProduct.route:(context)=>ManageProduct(),
          EditProduct.route:(context)=>EditProduct(),
          SignInPage.route:(context)=>SignInPage(),
          SignUpPage.route:(context)=>SignUpPage(),
        },
      ),
    );
  }
}
