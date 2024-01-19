import 'package:fcc_app_front/features/menu/data/models/product.dart';

List<ProductModel> searchProduct(
  String? query,
  List<ProductModel> allProducts,
) {
  if (query == null) return allProducts;
  List<ProductModel> products = <ProductModel>[];
  for (final ProductModel product in allProducts) {
    if (product.name.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (ProductModel e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  for (final ProductModel product in allProducts) {
    if (product.description.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (ProductModel e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  return products;
}
