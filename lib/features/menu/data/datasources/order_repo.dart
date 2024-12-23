import 'dart:convert';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/data/models/address.dart';

final class OrderRepository {
  static Future<Product?> getProductbyId({required String productUuid}) async {
    try {
      final String? response =
          await BaseHttpClient.get('api/v1/products/$productUuid');
      return Product.fromJson(
        jsonDecode(response.toString()) as Map<String, dynamic>,
      );
    } catch (e) {
      throw (OrderException(message: e.toString()));
    }
  }

  Future<List<Address>> searchAddressByName(String name) async {
    final List<Address> addresses = <Address>[];

    try {
      final String? response =
          await BaseHttpClient.get('delivery/search/$name');

      if (response != null) {
        final List body = jsonDecode(response) as List;
        for (dynamic address in body) {
          addresses.add(
            Address.fromJson(address),
          );
        }
      }
    } catch (e) {
      throw (OrderException(message: e.toString()));
    }
    return addresses;
  }
}
