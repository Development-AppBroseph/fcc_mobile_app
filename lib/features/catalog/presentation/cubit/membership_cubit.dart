import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:fcc_app_front/features/catalog/data/models/membership.dart';
import '../../../../shared/config/base_http_client.dart';

class MembershipCubit extends Cubit<List<MembershipModel>> {
  MembershipCubit() : super([]);
  load() async {
    try {
      final response = await BaseHttpClient.get('api/v1/users/memberships/');
      log(response.toString());
      if (response == null) return;
      List<MembershipModel> membershipList = [];
      final memberships = jsonDecode(response) as List;
      for (var element in memberships) {
        membershipList.add(
          MembershipModel.fromMap(element),
        );
      }
      emit(membershipList);
    } catch (e) {
      log("Couldn't get the membership types: $e");
    }
  }

  String getPrice(int id) {
    try {
      return super
              .state
              .firstWhereOrNull((element) => element.id == id)
              ?.price
              .toStringAsFixed(0) ??
          '-';
    } catch (e) {
      log('No membership with id $id');
    }
    return ' - ';
  }
}
