import 'package:fcc_app_front/features/menu/data/models/product.dart';

List<Product> searchProduct(
  String? query,
  List<Product> allProducts,
) {
  if (query == null) return allProducts;
  List<Product> products = <Product>[];
  for (final Product product in allProducts) {
    if (product.name.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (Product e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  for (final Product product in allProducts) {
    if (product.description.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (Product e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  return products;
}
