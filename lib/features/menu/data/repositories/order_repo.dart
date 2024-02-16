import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class OrderRepo {
  static Future<OrderModel?> placeOrder({
    required String address,
    required String name,
    required String phone,
    required String email,
    required String productId,
  }) async {
    try {
      final Response response = await BaseHttpClient.postBody(
        'api/v1/orders/orders/',
        <String, Object?>{
          'client': getClientId(),
          'order_items': <Map<String, dynamic>>[
            <String, dynamic>{'product_id': productId, 'quantity': 1}
          ],
          'shipping_price': '0',
          'delivery_point': 1,
          'client_name': name,
          'client_phone': phone,
          'client_email': email,
        },
      );
      Hive.box(HiveStrings.userBox).put(HiveStrings.address, address);
      if (response.statusCode < 300) {
        return OrderModel.fromJson(
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
        throw OrderException(message: 'limit reached');
      }
    } catch (e) {
      if (e is OrderException) rethrow;
      throw OrderException(message: 'limit reached');
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
        log(response.toString());
        for (var order in body) {
          try {
            if (order['client'] == getClientId()) {
              orders.add(
                OrderModel.fromJson(
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
        return OrderModel.fromJson(
          jsonDecode(response),
        );
      }
    } catch (e) {
      log("Couldn't place the order: $e");
    }
    return null;
  }
}
