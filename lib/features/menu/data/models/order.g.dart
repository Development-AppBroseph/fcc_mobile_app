// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int?,
      client: json['client'] as int?,
      orderItems: (json['order_items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['total_price'] as String?,
      shippingPrice: json['shipping_price'] as String?,
      deliveryPoint: json['delivery_point'] as String?,
      clientName: json['client_name'] as String?,
      clientPhone: json['client_phone'] as String?,
      clientEmail: json['client_email'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      trackNumber: json['track_number'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'order_items': instance.orderItems,
      'total_price': instance.totalPrice,
      'shipping_price': instance.shippingPrice,
      'delivery_point': instance.deliveryPoint,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'client_email': instance.clientEmail,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'delivery_status': instance.deliveryStatus,
      'track_number': instance.trackNumber,
      'created_at': instance.createdAt?.toIso8601String(),
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      productUuid: json['product_uuid'] as String,
      productName: json['product_name'] as String,
      productPhoto: json['product_photo'] as String,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'product_uuid': instance.productUuid,
      'product_name': instance.productName,
      'product_photo': instance.productPhoto,
      'quantity': instance.quantity,
    };
