// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      format: json['format'] as String,
      strength: json['strength'] as String,
      tasty: json['tasty'] as String,
      mark: json['mark'] as String,
      country: json['country'] as String,
      price: json['price'] as String,
      stock: json['stock'] as int,
      image: json['image'] as String,
      active: json['active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      catalog: json['catalog'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'description': instance.description,
      'format': instance.format,
      'strength': instance.strength,
      'tasty': instance.tasty,
      'mark': instance.mark,
      'country': instance.country,
      'price': instance.price,
      'stock': instance.stock,
      'image': instance.image,
      'active': instance.active,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'catalog': instance.catalog,
    };
