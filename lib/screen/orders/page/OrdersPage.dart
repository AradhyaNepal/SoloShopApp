import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/common/Widgets/DrawerWidget.dart';
import 'package:solo_shop_app_practice/screen/orders_detail/providers/OrderProvider.dart';
import 'package:solo_shop_app_practice/screen/orders_detail/widgets/OrdersWidget.dart';

class OrderPage  extends StatelessWidget {
  static const route='/OrderPage';
  @override
  Widget build(BuildContext context) {
    final ordersProvider=Provider.of<OrderProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context,index)=>OrdersWidget(order: ordersProvider.orders[index])
      ),
    );
  }
}
