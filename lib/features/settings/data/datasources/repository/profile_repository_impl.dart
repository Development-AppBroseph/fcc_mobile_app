import 'dart:developer';

import 'package:fcc_app_front/features/settings/data/datasources/repository/profile_repository.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';
import 'package:fcc_app_front/shared/constants/urls.dart';
import 'package:fcc_app_front/shared/exception.dart';

final class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<void> changeProfileDetails({
    required String name,
    required String surname,
    required String email,
    required String middlename,
  }) async {
    try {
      final String? response = await BaseHttpClient.patch(
          changeMyProfileDetailsEndpoint, <String, String>{
        'first_name': name,
        'last_name': surname,
        'middle_name': middlename,
        'email': email,
      });

      log(response ?? 'response is null');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
