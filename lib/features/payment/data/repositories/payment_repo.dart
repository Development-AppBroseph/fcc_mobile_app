import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/features/payment/data/models/payment.dart';
import 'package:fcc_app_front/shared/config/utils/get_token.dart';
import 'package:http/http.dart';

import '../../../../shared/config/base_http_client.dart';

class PaymentRepo {
  static Future<String?> getWeblink(int membership, String amount) async {
    try {
      Response? response;
      response = await BaseHttpClient.post('api/v1/users/generate-payment-link/', {
        'client': getClientId(),
        'membership': membership,
        'amount': amount,
      });
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
      final response = await BaseHttpClient.get('api/v1/users/latest-payment/');
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
