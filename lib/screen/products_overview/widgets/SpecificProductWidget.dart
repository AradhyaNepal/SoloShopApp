import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/product_cart/providers/CartProvider.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'package:solo_shop_app_practice/screen/product_detail/page/ProductDetails.dart';

class SpecificProductWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    return ClipRRect(

      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, ProductDetails.route,arguments: product.id),
            child: Image.network(
                product.imageUrl,
              fit: BoxFit.cover,

            ),
          ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: (){
              product.toggleFavorites();
              //Provider.of<ProductsProvider>(context).updateProvider();
            } ,
            icon: Icon(
                product.isFavorite?Icons.favorite:Icons.favorite_border),

            color: Theme.of(context).accentColor,

          ),
          trailing: IconButton(
            onPressed: (){},
            icon: IconButton(
              onPressed:(){
                Provider.of<CartProvider>(context,listen: false).addItem(product.id, product.price, product.title);
              },
                icon:Icon(Icons.shopping_cart_sharp)
            ),
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
