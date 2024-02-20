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
  final String deliveryStatus;
  final DeliveryPoint? deliveryPoint;
  final DateTime createdAt;
  final String status;

  OrderModel({
    required this.deliveryStatus,
    this.deliveryPoint,
    required this.status,
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
      deliveryStatus: json['delivery_status'] ?? '',
      deliveryPoint: DeliveryPoint.fromJson(json['delivery_point']),
      status: json['status'] ?? '',
      id: json['id'] ?? 0,
      client: json['client'] ?? 0,
      orderItems: (json['order_items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          <OrderItem>[],
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

class DeliveryPoint {
  final int id;
  final String address;
  double latitude;
  double longitude;

  DeliveryPoint({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory DeliveryPoint.fromJson(Map<String, dynamic> json) {
    return DeliveryPoint(
      id: json['id'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  DeliveryPoint copyWith({
    int? id,
    String? address,
    double? latitude,
    double? longitude,
  }) =>
      DeliveryPoint(
        id: id ?? this.id,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
}
