class Cart{
  final String id;
  final String title;
  final int quantity;
  final double price;
  static int maxNumber=0;
  Cart({required this.id,required this.title,required this.quantity,required this.price});

  static String get uniqueId{
    maxNumber++;
    return 'C'+maxNumber.toString();
  }

}