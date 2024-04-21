import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "client")
  final int? client;
  @JsonKey(name: "order_items")
  final List<OrderItem>? orderItems;
  @JsonKey(name: "total_price")
  final String? totalPrice;
  @JsonKey(name: "shipping_price")
  final String? shippingPrice;
  @JsonKey(name: "delivery_point")
  final String? deliveryPoint;
  @JsonKey(name: "client_name")
  final String? clientName;
  @JsonKey(name: "client_phone")
  final String? clientPhone;
  @JsonKey(name: "client_email")
  final String? clientEmail;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "delivery_status")
  final String? deliveryStatus;
  @JsonKey(name: "track_number")
  final String? trackNumber;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  OrderModel({
    required this.id,
    required this.client,
    required this.orderItems,
    required this.totalPrice,
    required this.shippingPrice,
    required this.deliveryPoint,
    required this.clientName,
    required this.clientPhone,
    required this.clientEmail,
    required this.updatedAt,
    required this.status,
    required this.deliveryStatus,
    required this.trackNumber,
    required this.createdAt,
  });

  OrderModel copyWith({
    int? id,
    int? client,
    List<OrderItem>? orderItems,
    String? totalPrice,
    String? shippingPrice,
    String? deliveryPoint,
    String? clientName,
    String? clientPhone,
    String? clientEmail,
    DateTime? updatedAt,
    String? status,
    String? deliveryStatus,
    String? trackNumber,
    DateTime? createdAt,
  }) =>
      OrderModel(
        id: id ?? this.id,
        client: client ?? this.client,
        orderItems: orderItems ?? this.orderItems,
        totalPrice: totalPrice ?? this.totalPrice,
        shippingPrice: shippingPrice ?? this.shippingPrice,
        deliveryPoint: deliveryPoint ?? this.deliveryPoint,
        clientName: clientName ?? this.clientName,
        clientPhone: clientPhone ?? this.clientPhone,
        clientEmail: clientEmail ?? this.clientEmail,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        trackNumber: trackNumber ?? this.trackNumber,
        createdAt: createdAt ?? this.createdAt,
      );

  factory OrderModel.fromMap(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product_uuid")
  final String productUuid;
  @JsonKey(name: "product_name")
  final String productName;
  @JsonKey(name: "product_photo")
  final String productPhoto;
  @JsonKey(name: "quantity")
  final int quantity;

  OrderItem({
    required this.productUuid,
    required this.productName,
    required this.productPhoto,
    required this.quantity,
  });

  OrderItem copyWith({
    String? productUuid,
    String? productName,
    String? productPhoto,
    int? quantity,
  }) =>
      OrderItem(
        productUuid: productUuid ?? this.productUuid,
        productName: productName ?? this.productName,
        productPhoto: productPhoto ?? this.productPhoto,
        quantity: quantity ?? this.quantity,
      );

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
