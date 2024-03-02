import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/data/models/address.dart';

final class OrderRepository {
  static Future<ProductModel?> getProductbyId(
      {required String productUuid}) async {
    try {
      final String? response =
          await BaseHttpClient.get('api/v1/products/$productUuid');
      return ProductModel.fromMap(
        jsonDecode(response.toString()) as Map<String, dynamic>,
      );
    } catch (e) {
      throw (OrderException(message: e.toString()));
    }
  }

  Future<List<Address>> getAllAddreses() async {
    final List<Address> addresses = <Address>[];

    try {
      final String? response = await BaseHttpClient.get('delivery/addresses/');

      if (response != null) {
        final List body = jsonDecode(response) as List;
        for (dynamic address in body) {
          addresses.add(
            Address.fromJson(address),
          );
        }
      }
      log(addresses.toString());
    } catch (e) {
      throw (OrderException(message: e.toString()));
    }
    return addresses;
  }
}
