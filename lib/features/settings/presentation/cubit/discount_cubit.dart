import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';
part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  DiscountCubit()
      : super(
          const DiscountState(
            0,
            0,
          ),
        );
  dynamic load() async {
    try {
      final String? discount = await BaseHttpClient.get(
        'api/v1/discounts/discount/',
      );
      if (discount != null) {
        emit(
          DiscountState(
            jsonDecode(discount)['invited_count'] as int,
            jsonDecode(discount)['discount_percentage'] as int,
          ),
        );
      }
    } catch (e) {
      log("Couldn't get the discount: $e");
    }
  }
}
