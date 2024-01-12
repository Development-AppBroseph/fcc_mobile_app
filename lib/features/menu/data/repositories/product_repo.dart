import 'dart:convert';
import 'dart:developer';

import '../../../../shared/config/utils/get_token.dart';
import '../models/product.dart';
import '../../../../shared/config/base_http_client.dart';

class ProductRepo {
  static Future<List<ProductModel>> getProducts({bool isPublic = false}) async {
    List<ProductModel> products = [];
    final token = getToken();
    final response = token == null || isPublic
        ? await BaseHttpClient.get(
            'api/v1/products/public/products/',
          )
        : await BaseHttpClient.get(
            'api/v1/products/products/',
          );
    if (response != null) {
      try {
        final productsData = jsonDecode(response) as List;
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
