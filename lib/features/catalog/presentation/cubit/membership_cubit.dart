import 'dart:convert';
import 'dart:developer';
import 'package:fcc_app_front/export.dart';
import 'package:http/http.dart' as http;

class MembershipCubit extends Cubit<List<MembershipModel>> {
  MembershipCubit() : super(<MembershipModel>[]);
  Map<int, bool> availabilityMap = {};

  Future<void> load() async {
    try {
      final Response response = await http.Client().get(Uri.parse('${baseUrl}api/v1/users/memberships/'));
      log(response.body.toString());
      List<MembershipModel> membershipList = <MembershipModel>[];
      final List memberships = jsonDecode(response.body) as List;
      for (var element in memberships) {
        membershipList.add(
          MembershipModel.fromMap(element),
        );
      }

      // Clear the availability map before repopulating it
      availabilityMap.clear();

      // Check availability for each membership
      for (var membership in membershipList) {
        bool available = await checkAvailability(membership.id);
        availabilityMap[membership.id] = available;
      }

      // Emit the updated state with availability
      emit(List.from(membershipList));
    } catch (e) {
      log("Couldn't get the membership types: $e");
    }
  }

  Future<bool> checkAvailability(int id) async {
    try {
      final Response response = await http.Client().get(Uri.parse('${baseUrl}api/v1/users/tariff-available/$id/'));
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['available'] ?? false;
    } catch (e) {
      log("Couldn't check the availability of membership type $id: $e");
      return false;
    }
  }

  String getPrice(int id) {
    try {
      return super.state.firstWhereOrNull((MembershipModel element) {
        return element.id == id;
      })?.price.toStringAsFixed(0) ?? '-';
    } catch (e) {
      log('No membership with id $id');
    }
    return ' - ';
  }

  bool isAvailable(int id) {
    return availabilityMap[id] ?? false;
  }
}
