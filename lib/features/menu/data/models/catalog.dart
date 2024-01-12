import 'dart:math';

class CatalogModel {
  final int id;
  final String name;
  final String description;
  final String membership;
  final String? image;
  CatalogModel({
    required this.id,
    required this.name,
    required this.description,
    required this.membership,
    this.image,
  });

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(
      id: map['id'] ?? Random().nextInt(1000),
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      membership: map['membership_level'] ?? 'standard',
      image: map['catalog_image'],
    );
  }
}
