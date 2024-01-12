import '../models/product.dart';

List<ProductModel> searchProduct(
  String? query,
  List<ProductModel> allProducts,
) {
  if (query == null) return allProducts;
  List<ProductModel> products = [];
  for (final product in allProducts) {
    if (product.name.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  for (final product in allProducts) {
    if (product.description.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  return products;
}
