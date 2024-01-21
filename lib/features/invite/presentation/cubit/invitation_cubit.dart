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
}
