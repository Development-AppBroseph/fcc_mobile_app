class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final int catalog;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.catalog,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['uuid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: double.parse(
        (map['price'] ?? 0).toString(),
      ),
      stock: map['stock'] ?? 1,
      image: map['image'] ?? '',
      catalog: map['catalog'] ?? 0,
    );
  }
}
