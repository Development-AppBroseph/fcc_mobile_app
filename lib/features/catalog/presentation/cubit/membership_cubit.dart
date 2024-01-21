import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class MembershipCubit extends Cubit<List<MembershipModel>> {
  MembershipCubit() : super(<MembershipModel>[]);
  Future<void> load() async {
    try {
      final String? response = await BaseHttpClient.get('api/v1/users/memberships/');
      log(response.toString());
      if (response == null) return;
      List<MembershipModel> membershipList = <MembershipModel>[];
      final List memberships = jsonDecode(response) as List;
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
      return super.state.firstWhereOrNull((MembershipModel element) => element.id == id)?.price.toStringAsFixed(0) ??
          '-';
    } catch (e) {
      log('No membership with id $id');
    }
    return ' - ';
  }
}
