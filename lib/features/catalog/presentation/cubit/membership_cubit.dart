import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:http/http.dart' as http;

class MembershipCubit extends Cubit<List<MembershipModel>> {
  MembershipCubit() : super(<MembershipModel>[]);
  Future<void> load() async {
    try {
      final Response response = await http.Client().get(Uri.parse(
        '${baseUrl}api/v1/users/memberships/',
      ));
      log(response.body.toString());
      List<MembershipModel> membershipList = <MembershipModel>[];
      final List memberships = jsonDecode(response.body) as List;
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
              .firstWhereOrNull((MembershipModel element) {
                return element.id == id;
              })
              ?.price
              .toStringAsFixed(0) ??
          '-';
    } catch (e) {
      log('No membership with id $id');
    }
    return ' - ';
  }
}
