import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/cart/providers/CartProvider.dart';
class CartWidget extends StatelessWidget {
  final String id,title,productId;
  final double price;
  final int quantity;
  CartWidget({required this.id,required this.productId,required this.title,required this.price, required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_){
        return showDialog(
            context: context,
            builder: (context){
                return AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you really want to remove item form the cart'),
                  actions: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context,true);
                        },
                        child: Text('Yes')
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context,false);

                        },
                        child: Text('No')
                    ),
                  ],
                );
            });
      },
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 49,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_){
        Provider.of<CartProvider>(context,listen: false).removeItem(productId);
      },

      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(child: Text('$price'),),
            title: Text(title),
            subtitle: Text('Total: ${price*quantity}'),
            trailing: Text('$quantity'),
          )
        ),
      ),
    );
  }
}
