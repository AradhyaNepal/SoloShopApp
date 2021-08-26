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
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,

              child: Image.network(
                loadedProduct.imageUrl,
                fit:BoxFit.cover,
              ),
            ),
            SizedBox(height: 10,),
            Text('${loadedProduct.price})'),
            SizedBox(height: 10,),
            Text(loadedProduct.description),
          ],
        ),
      ),
    );
  }
}
