import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class ProductRepo {
  static Future<List<Product>> getProducts({
    bool isPublic = false,
    required String catalogId,
  }) async {
    List<Product> products = <Product>[];
    final String? token = getToken();
    final String? response = token == null || isPublic
        ? await BaseHttpClient.get(
            'api/v1/products/catalogs/$catalogId/products/',
          )
        : await BaseHttpClient.get(
            'api/v1/products/catalogs/$catalogId/products/',
          );
    print(response.toString());
    if (response != null) {
      try {
        final List<dynamic> productsData = jsonDecode(response);
        for (final productJson in productsData) {
          final Product product = Product.fromJson(productJson as Map<String, dynamic>);
          products.add(product);
        }
      } catch (e) {
        log("Couldn't get the products: $e");
      }
    }
    return products;
  }
}
