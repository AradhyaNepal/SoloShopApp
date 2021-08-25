import 'package:solo_shop_app_practice/models/Cart.dart';

class Order{
  final String id;
  final double amount;
  final List<Cart> products;
  final DateTime dateTime;
  static int maxNumber=0;

  Order({
    required this.id,
      required this.amount,
    required this.products,
    required this.dateTime
  });

  static String get uniqueId{
    maxNumber++;
    return 'O'+maxNumber.toString();
  }
}