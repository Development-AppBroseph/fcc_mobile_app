import 'package:fcc_app_front/features/menu/data/models/catalog.dart';

List<CatalogModel> searchCatalog(
  String? query,
  List<CatalogModel> allProducts,
) {
  if (query == null) return allProducts;
  List<CatalogModel> products = <CatalogModel>[];
  for (final CatalogModel product in allProducts) {
    if (product.name.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (CatalogModel e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  for (final CatalogModel product in allProducts) {
    if (product.description.toLowerCase().contains(
              query.toLowerCase(),
            ) &&
        !products.any(
          (CatalogModel e) => e.id == product.id,
        )) {
      products.add(product);
    }
  }
  return products;
}
