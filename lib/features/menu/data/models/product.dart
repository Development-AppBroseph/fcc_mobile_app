import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'uuid')
  String uuid;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'format')
  String format;
  @JsonKey(name: 'strength')
  String strength;
  @JsonKey(name: 'tasty')
  String tasty;
  @JsonKey(name: 'mark')
  String mark;
  @JsonKey(name: 'country')
  String country;
  @JsonKey(name: 'price')
  String price;
  @JsonKey(name: 'stock')
  int stock;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'active')
  bool active;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'catalog')
  int catalog;

  Product({
    required this.id,
    required this.uuid,
    required this.name,
    required this.description,
    required this.format,
    required this.strength,
    required this.tasty,
    required this.mark,
    required this.country,
    required this.price,
    required this.stock,
    required this.image,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.catalog,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  // Map<String, dynamic> toJson() => _$ProductToJson(this);
}
