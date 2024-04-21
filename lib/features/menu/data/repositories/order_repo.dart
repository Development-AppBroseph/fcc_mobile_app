import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class OrderRepo {
  static Future<(OrderModel?, String?)> placeOrder({
    required String address,
    required String name,
    required String phone,
    required String email,
    required ProductModel product,
  }) async {
    try {
      final Response response = await BaseHttpClient.postBody(
        'api/v1/orders/orders/',
        <String, Object?>{
          'client': getClientId(),
          'order_items': <Map<String, dynamic>>[
            <String, dynamic>{
              'product_uuid': product.id,
              'quantity': 4,
            }
          ],
          'shipping_price': '0',
          'delivery_point': address,
          'client_name': name,
          'client_phone': phone,
          'client_email': email,
        },
      );

      if (response.statusCode == 400 &&
          const Utf8Decoder()
              .convert(response.bodyBytes)
              .contains('Слишком мало кол-во товаров в наличии')) {
        print(
          response.body,
        );
        return (null, 'Слишком мало количества товаров в наличии');
      }

      Hive.box(HiveStrings.userBox).put(HiveStrings.address, address);
      if (response.statusCode < 300) {
        return (
          OrderModel.fromMap(jsonDecode(utf8.decode(response.bodyBytes))),
          null
        );
      } else if (jsonDecode(
        utf8.decode(
          response.bodyBytes,
        ),
      )['message']
          .contains('Order limit reached')) {
        throw OrderException(message: 'Order limit reached');
      }
    } catch (e) {
      if (e is OrderException) rethrow;
      throw OrderException(message: 'Order limit reached');
    }
    return (null, null);
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
