import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/SpecificUserProduct.dart';
import 'package:solo_shop_app_practice/common/Widgets/DrawerWidget.dart';
import 'package:solo_shop_app_practice/edit_product.dart';
import 'package:solo_shop_app_practice/screen/products_overview/providers/ProductsProvider.dart';

class ManageProduct extends StatelessWidget {
  static const route='/ManageProduct';
  @override
  Widget build(BuildContext context) {
    final productProvider=Provider.of<ProductsProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, EditProduct.route,);

              },
              icon: Icon(Icons.add))

        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productProvider.items.length,
          itemBuilder: (context,index)=>SpecificUserProduct(
            id: productProvider.items[index].id,
              title: productProvider.items[index].title,
              imageUrl: productProvider.items[index].imageUrl),
        ),
      ),
    );
  }
}
