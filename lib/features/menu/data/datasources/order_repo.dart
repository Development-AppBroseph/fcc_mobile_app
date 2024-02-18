import 'dart:convert';

import 'package:fcc_app_front/features/menu/data/models/address.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';

final class OrderRepository {
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
      print(addresses);
    } catch (e) {
      print(e);
    }
    return addresses;
  }
}
