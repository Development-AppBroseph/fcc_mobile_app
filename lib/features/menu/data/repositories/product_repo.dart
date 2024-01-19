import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class ProductRepo {
  static Future<List<ProductModel>> getProducts({bool isPublic = false}) async {
    List<ProductModel> products = <ProductModel>[];
    final String? token = getToken();
    final String? response = token == null || isPublic
        ? await BaseHttpClient.get(
            'api/v1/products/public/products/',
          )
        : await BaseHttpClient.get(
            'api/v1/products/products/',
          );
    if (response != null) {
      try {
        final List productsData = jsonDecode(response) as List;
        for (final product in productsData) {
          products.add(
            ProductModel.fromMap(
              product,
            ),
          );
        }
      } catch (e) {
        log("Couldn't get the products: $e");
      }
    }
    return products;
  }
}
