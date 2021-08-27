import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'package:solo_shop_app_practice/screen/authetication/provider/Auth.dart';
import 'package:solo_shop_app_practice/screen/cart/providers/CartProvider.dart';
import '../page/ProductDetails.dart';

class SpecificProductWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    final cartProvider=Provider.of<CartProvider>(context,listen: false);
    final auth=Provider.of<Auth>(context,listen: false);
    return ClipRRect(

      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, ProductDetails.route,arguments: product.id),
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder: AssetImage('images/placeholder.jpg'),
                image: NetworkImage(
                    product.imageUrl
                ),
                ),
              ),
            ),
          
        footer: ChangeNotifierProvider(
          create: (context)=>product,
            child: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (context,productToggle,child){
                  return IconButton(
                    onPressed: (){
                      productToggle.toggleFavorites(auth.token,auth.userId);
                    } ,
                    icon: Icon(
                        productToggle.isFavorite?Icons.favorite:Icons.favorite_border, color: Colors.red,
                    ),

                    color: Theme.of(context).accentColor,

                  );
                }
              ),

              trailing: IconButton(
                onPressed: (){},
                icon: IconButton(
                  onPressed:(){
                    Provider.of<CartProvider>(context,listen: false).addItem(product.id, product.price, product.title);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content:
                        Text('Added item to cart'),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: (){
                              cartProvider.removeSingleItem(product.id );

                            },
                          )
                        ),
                    );
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
    ),
    );


  }
}
