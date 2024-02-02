import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class OrderRepo {
  static Future<OrderModel?> placeOrder({
    required ProductModel product,
    required String address,
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      final Response response = await BaseHttpClient.postBody(
        'api/v1/orders/orders/',
        <String, Object?>{
          'client': getClientId(),
          'order_items': <Map<String, int>>[
            <String, int>{'product': product.id, 'quantity': 1}
          ],
          'shipping_price': '0',
          'pickup_address': address,
          'client_name': name,
          'client_phone': phone,
          'client_email': email,
        },
      );
      Hive.box(HiveStrings.userBox).put(HiveStrings.address, address);
      if (response.statusCode < 300) {
        return OrderModel.fromMap(
          jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          ),
        );
      } else if (jsonDecode(
        utf8.decode(
          response.bodyBytes,
        ),
      )['message']
          .contains('limit reached')) {
        throw OrderException();
      }
    } catch (e) {
      if (e is OrderException) rethrow;
      log("Couldn't place the order: $e");
    }
    return null;
  }

  static Future<List<OrderModel>> getOrders() async {
    List<OrderModel> orders = <OrderModel>[];
    try {
      final String? response = await BaseHttpClient.get(
        'api/v1/orders/orders/',
      );
      if (response != null) {
        final List body = jsonDecode(response) as List;
        for (var order in body) {
          try {
            if (order['client'] == getClientId()) {
              orders.add(
                OrderModel.fromMap(
                  order,
                ),
              );
            }
          } catch (e) {
            log("Couldn't get order - $order \n $e");
          }
        }
      }
    } catch (e) {
      log("Couldn't place the order: $e");
    }
    return orders;
  }

  static Future<OrderModel?> updateOrderAddress(
    String address,
    int id,
  ) async {
    try {
      Hive.box(HiveStrings.userBox).put(HiveStrings.address, address);

      final response = await BaseHttpClient.patch(
        'api/v1/orders/orders/$id/',
        <String, String>{
          'pickup_address': address,
        },
      );

      if (response != null) {
        return OrderModel.fromMap(
          jsonDecode(response),
        );
      }
    } catch (e) {
      log("Couldn't place the order: $e");
    }
    return null;
  }
}
