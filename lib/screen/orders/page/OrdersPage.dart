import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/common/Widgets/DrawerWidget.dart';
import 'package:solo_shop_app_practice/screen/orders/providers/OrderProvider.dart';
import 'package:solo_shop_app_practice/screen/orders/widgets/OrdersWidget.dart';

class OrderPage extends StatelessWidget {
  static const route='/OrderPage';
  @override
  Widget build(BuildContext context) {
    //final ordersProvider=Provider.of<OrderProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body:FutureBuilder(
        future:  Provider.of<OrderProvider>(context,listen: false).fetchOrder(),
        builder: (context,snapShot){
          if(snapShot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (snapShot.error != null){
            return Consumer<OrderProvider>(
              builder: (context,ordersProvider,child){
                return ListView.builder(

                    itemCount: ordersProvider.orders.length,
                    itemBuilder: (context,index)=>OrdersWidget(order: ordersProvider.orders[index])
                );
              },
            );
          }
          return Center(child: Text('No Data'));
        },
      )
    );
  }
}
