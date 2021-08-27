import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/common/Widgets/DrawerWidget.dart';
import 'package:solo_shop_app_practice/screen/products/providers/ProductsProvider.dart';
import 'package:solo_shop_app_practice/screen/products/widgets/CartMenu.dart';
import 'package:solo_shop_app_practice/screen/products/widgets/ProductGrid.dart';

class ProductsOverview  extends StatefulWidget {
  static const route='/';

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _favChoosen=false;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value){
              setState(() {
                if(value==0){
                  _favChoosen=true;
                }
                else{
                  _favChoosen=false;
                }
              });

            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(
                child: Text('Only Favorites'),value: 0,
              ),
              PopupMenuItem(
                child: Text('Show All'),value: 1,
              ),

            ],
          ),
          CartMenu(),
        ],
      ),

      body: isLoading?Center(
        child: CircularProgressIndicator(),
      ):ProductGrid(_favChoosen),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {

      isLoading=true;
    });
    Provider.of<ProductsProvider>(context,listen: false).fetchProduct()//Or use Future.delayed(Duration.zero) because its treated as to do action by dart
    .then((value) {
      setState(() {
        isLoading=false;
      });
    }
    );
    super.initState();
  }
}
