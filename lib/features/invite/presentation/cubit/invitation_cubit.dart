import 'dart:convert';
import 'dart:developer';
import 'package:fcc_app_front/export.dart';

class InvitationCubit extends Cubit<InvitationModel?> {
  InvitationCubit() : super(null);
  dynamic load() async {
    try {
      final String? invitation = await BaseHttpClient.get(
        'api/v1/users/invitation_details/',
      );
      if (invitation != null) {
        emit(
          InvitationModel(
            link: jsonDecode(invitation)['invitation_link'],
            qrCode: jsonDecode(invitation)['qr_code'],
          ),
        );
      }
    } catch (e) {
      log("Couldn't get the invitation: $e");
    }
  }

  Future<bool> checkCanInvite() async {
    final token = getToken();
    if (token == null) return false;
    try {
      final response = await BaseHttpClient.get(
        'api/v1/users/check-can-invite/',
        headers: {'Authorization': 'Bearer $token'},
      );

      final Map<String, dynamic> data = jsonDecode(response!);
      return data['can_invite'] ?? false;
    } catch (e) {
      log("Error checking invite permission: $e");
      return false;
    }
  }
}
