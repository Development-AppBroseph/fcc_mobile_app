import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class PaymentRepo {
  static Future<String?> getWeblink(
    int membership,
    String amount,
  ) async {
    try {
      Response? response;
      response = await BaseHttpClient.post(
          'api/v1/users/generate-payment-link/', <String, Object?>{
        'client': getClientId(),
        'membership': membership,
        'amount': amount,
      });

      if (response?.statusCode == 201) {
        return 'free';
      }

      if (response != null) {
        log(jsonDecode(response.body)['paymentUrl'] as String);
        return jsonDecode(response.body)['paymentUrl'] as String;
      }
    } catch (e) {
      log("Couldn't get payment url: $e");
    }
    return null;
  }

  static Future<PaymentModel?> latestPayment() async {
    try {
      final String? response =
          await BaseHttpClient.get('api/v1/users/latest-payment/');
      if (response != null) {
        return PaymentModel.fromMap(
          jsonDecode(response),
        );
      }
    } catch (e) {
      log("Couldn't get latestPayment: $e");
    }
    return null;
  }
}
