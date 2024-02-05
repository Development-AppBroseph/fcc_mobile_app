class OrderModel {
  final int id;
  final int client;
  final List<OrderItem> orderItems;
  final String totalPrice;
  final String shippingPrice;
  final String pickupAddress;
  final String clientName;
  final String clientPhone;
  final String clientEmail;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.client,
    required this.orderItems,
    required this.totalPrice,
    required this.shippingPrice,
    required this.pickupAddress,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      client: json['client'] ?? 0,
      orderItems:
          (json['order_items'] as List<dynamic>?)?.map((item) => OrderItem.fromJson(item)).toList() ?? <OrderItem>[],
      totalPrice: json['total_price'] ?? '',
      shippingPrice: json['shipping_price'] ?? '',
      pickupAddress: json['pickup_address'] ?? '',
      clientName: json['client_name'] ?? '',
      clientPhone: json['client_phone'] ?? '',
      clientEmail: json['client_email'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
    );
  }
}

class OrderItem {
  final int productId;
  final String productName;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product'] ?? 0,
      productName: json['product_name'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}
