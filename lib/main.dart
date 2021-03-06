import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/ProfilePage.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/SignInPage.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/SignUpPage.dart';
import 'package:solo_shop_app_practice/screen/authetication/page/SplashPage.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/Auth.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/LoadingProvider.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/PickImageProvider.dart';
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
          create: (context){
            Auth authProvider=Provider.of<Auth>(context,listen: false);
            return ProductsProvider(authProvider.token, [],authProvider.userId);
           },
           update:(context,auth,previousProducts)=>ProductsProvider(auth.token,
               previousProducts == null?[]:previousProducts.items,auth.userId),
        ),
        ChangeNotifierProvider(
          create: (context)=>CartProvider(),
        ),
        ChangeNotifierProxyProvider<Auth,OrderProvider>(
            create: (context){
              Auth authProvider=Provider.of<Auth>(context,listen: false);
              return OrderProvider(authProvider.token,[], authProvider.userId);
            },
            update: (context,auth,previousOrder)=>OrderProvider(auth.token, previousOrder==null?[]:previousOrder.orders, auth.userId),

        ),
        ChangeNotifierProvider(
          create: (context)=>LoadingProvider(),
          ),

        ChangeNotifierProvider(
            create: (context)=>PickImageProvider()
        ),

      ],
      child: Consumer<Auth>(
        builder: (context,auth,child){
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'
            ),
            home: auth.isAuth?ProductsOverview():
                FutureBuilder(
                  future: auth.tryAutoLogin(),
                    builder:(context,snapshot){
                    return snapshot.connectionState==ConnectionState.waiting?SplashPage():SignInPage();
                     }
                ),

            routes: {
              ProductsOverview.route:(context)=>ProductsOverview(),
              ProductDetails.route:(context)=>ProductDetails(),
              CartPage.route:(context)=>CartPage(),
              OrderPage.route:(context)=>OrderPage(),
              ManageProduct.route:(context)=>ManageProduct(),
              EditProduct.route:(context)=>EditProduct(),
              SignInPage.route:(context)=>SignInPage(),
              SignUpPage.route:(context)=>SignUpPage(),
              ProfilePage.route:(context)=>ProfilePage(),
            },
          );
        },
      ),
    );
  }
}
