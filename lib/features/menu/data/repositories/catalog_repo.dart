import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class CatalogRepo {
  static Future<List<CatalogModel>> getCatalogs({
    required String catalogId,
    bool isPublic = false,
  }) async {
    List<CatalogModel> catalogs = <CatalogModel>[];
    final String? token = getToken();
    try {
      final String? response = token == null || isPublic
          ? await BaseHttpClient.get(
              'api/v1/products/catalogs/',
              haveToken: false,
              headers: <String, String>{
                'membership_id': catalogId,
              },
            )
          : await BaseHttpClient.get(
              headers: <String, String>{
                'membership_id': catalogId,
              },
              'api/v1/products/catalogs/',
            );
      if (response != null) {
        final List productsData = jsonDecode(response) as List;
        for (final product in productsData) {
          try {
            catalogs.add(
              CatalogModel.fromMap(
                product,
              ),
            );
          } catch (e) {
            log("Couldn't catalog from map: $e");
            log(product.toString());
          }
        }
      }
    } catch (e) {
      log("Couldn't get the catalogs: $e");
    }
    return catalogs;
  }
}
