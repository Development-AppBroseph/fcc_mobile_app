import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fcc_app_front/features/invite/data/models/invitation.dart';

import '../../../../shared/config/base_http_client.dart';

class InvitationCubit extends Cubit<InvitationModel?> {
  InvitationCubit() : super(null);
  load() async {
    try {
      final invitation = await BaseHttpClient.get(
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
