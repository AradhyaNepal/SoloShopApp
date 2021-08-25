import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/edit_product.dart';
import 'package:solo_shop_app_practice/screen/products_overview/providers/ProductsProvider.dart';

class SpecificUserProduct extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function deleteMe
  SpecificUserProduct({required this.title,required this.imageUrl,required this.id});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.pushNamed(context, EditProduct.route,arguments:id);

              },
                icon: Icon(Icons.edit,color: Colors.purple,)
            ),
            IconButton(
                onPressed: (){
                  Provider.of<ProductsProvider>(context).deleteProduct(id);

                },
                icon: Icon(Icons.delete,color: Colors.red,)
            ),
          ],
        ),
      ),
    );
  }
}
