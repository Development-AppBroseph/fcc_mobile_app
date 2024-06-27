class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final int catalog;
  final String taste;
  final String country;
  final String strenght;
  final String format;
  final String mark;

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      format: map['format'] ?? '',
      strenght: map['strength'] ?? '',
      taste: map['tasty'] ?? '',
      country: map['country'] ?? '',
      id: map['uuid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: double.parse(
        (map['price'] ?? 0).toString(),
      ),
      stock: map['stock'] ?? 1,
      image: map['image'] ?? '',
      catalog: map['catalog'] ?? 0,
      mark: map['mark'] ?? '',
    );
  }

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.catalog,
    required this.taste,
    required this.country,
    required this.strenght,
    required this.format,
    required this.mark,
  });
}
