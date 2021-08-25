import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solo_shop_app_practice/models/Cart.dart';
import 'package:solo_shop_app_practice/models/Order.dart';

class OrdersWidget extends StatefulWidget {
  final Order order;
  OrdersWidget({required this.order});

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  bool _expanded=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(title: Text('${widget.order.amount}'),
        //TODO: Supposed to import init to format date and display in subtitle
          trailing: IconButton(
            onPressed: (){
              setState(() {
                _expanded=!_expanded;
              });

            },
            icon: Icon(_expanded?Icons.expand_less:Icons.expand_more),
          ),
        ),
        if (_expanded) Container(
          height: min(widget.order.products.length*20+100,180),
          child: ListView.builder(
            itemBuilder: (context,index){
              Cart cart=widget.order.products[index];
              return Row(
                children: [
                  Text('${cart.quantity} x ${cart.price}')
                ],
              );
            },
            itemCount: widget.order.products.length,
          ),
        )
      ],),
    );
  }
}
