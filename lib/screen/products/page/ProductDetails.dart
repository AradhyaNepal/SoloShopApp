import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'package:solo_shop_app_practice/screen/products/providers/ProductsProvider.dart';

class ProductDetails extends StatelessWidget {
  static const route='/ProductDetails';

  @override
  Widget build(BuildContext context) {
    final String id=ModalRoute.of(context)!.settings.arguments as String;
    Product loadedProduct=Provider.of<ProductsProvider>(context,listen: false).items.firstWhere((element) => element.id==id);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     loadedProduct.title,
      //   ),
      //
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
              tag: id,
              child: Image.network(
                loadedProduct.imageUrl,
                fit:BoxFit.cover,
              ),
            ),
            ),

          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('${loadedProduct.price})'),
                    SizedBox(height: 10,),
                    Text(loadedProduct.description),
                    SizedBox(height:800 ,)
                  ],
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}
