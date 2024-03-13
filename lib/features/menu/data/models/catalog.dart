import 'dart:math';

import 'package:equatable/equatable.dart';

import 'package:fcc_app_front/export.dart';

class CatalogModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String membership;
  final String? image;
  const CatalogModel({
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

  @override
  List<Object?> get props {
    return <Object?>[
      id,
      name,
      description,
      membership,
      image,
    ];
  }
}
