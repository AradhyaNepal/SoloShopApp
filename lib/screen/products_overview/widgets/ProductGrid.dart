import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/products_overview/providers/ProductsProvider.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'SpecificProductWidget.dart';

class ProductGrid extends StatelessWidget {

  final bool favChoosen;
  ProductGrid(this.favChoosen);
  @override
  Widget build(BuildContext context) {
    final productsProvider=Provider.of<ProductsProvider>(context);
    List<Product> productData=favChoosen?productsProvider.favItems:productsProvider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productData.length,
      itemBuilder: (context,i) {
        return ChangeNotifierProvider.value(
          value:productData[i],
          child: SpecificProductWidget(),
        );

      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

    );
  }
}
