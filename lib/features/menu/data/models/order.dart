import 'dart:math';

class OrderModel {
  final int id;
  final double totalPrice;
  final DateTime date;
  final int clientId;
  final List<int> products;
  final String address;
  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.date,
    required this.clientId,
    required this.products,
    required this.address,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? Random().nextInt(1000),
      totalPrice: double.parse(
        (map['total_price'] ?? '0').toString(),
      ),
      date: DateTime.parse(
        map['order_date'] ?? map['created_at'] as String,
      ),
      clientId: map['client'] ?? Random().nextInt(1000),
      address: map['pickup_address'] ?? '',
      products: (map['order_items'] as List).map((e) => e['product'] as int).toList(),
    );
  }
}
