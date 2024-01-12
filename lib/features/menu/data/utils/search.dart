import 'package:fcc_app_front/features/menu/data/models/catalog.dart';

List<CatalogModel> searchCatalog(
  String? query,
  List<CatalogModel> allProducts,
) {
  if (query == null) return allProducts;
  List<CatalogModel> products = [];
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
