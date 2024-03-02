import 'dart:convert';
import 'dart:developer';
import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/data/models/membership.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static Future<bool> register(String phoneNumber) async {
    try {
      final Response? response = await BaseHttpClient.post(
        'api/v1/users/auth/register/',
        <String, String>{
          'phone_number': phoneNumber,
          'invite_code': Hive.box(HiveStrings.userBox).get(
            HiveStrings.invite,
          )
        },
        haveToken: false,
      );
      if (response != null) {
        log(
          jsonDecode(
                utf8.decode(
                  response.bodyBytes,
                ),
              )['message'] ??
              '',
        );
        return true;
      }
    } catch (e) {
      log('Someting wrong in register: $e');
      return false;
    }
    return false;
  }

  static Future<CurrentMembership?> getCurrentMembership() async {
    try {
      final String? response = await BaseHttpClient.get(
        'api/v1/users/my-current-membership/',
      );

      log(response.toString());
      return CurrentMembership.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      log('Someting wrong in getCurrentMembership: $e');
    }
    return null;
  }

  static Future<bool> sendSms(String phoneNumber) async {
    try {
      final Response? response = await BaseHttpClient.post(
        'api/v1/users/auth/send_verification_sms/',
        <String, String>{
          'phone_number': phoneNumber,
        },
        haveToken: false,
      );
      if (response != null) {
        log(
          jsonDecode(
                utf8.decode(
                  response.bodyBytes,
                ),
              )['message'] ??
              '',
        );
        return true;
      }
    } catch (e) {
      log('Someting wrong in sendSms: $e');
      return false;
    }
    return false;
  }

  static Future<UserModel?> getUser() async {
    try {
      final String? response = await BaseHttpClient.get(
        'api/v1/users/session/',
      );
      log(response.toString());
      if (response != null) {
        saveUserName(
          jsonDecode(
            response,
          ),
        );
        return UserModel.fromMap(
          jsonDecode(
            response,
          ),
        );
      }
    } catch (e) {
      log('Someting wrong in getUser: $e');
    }
    return null;
  }

  static Future<bool> checkRegistration(String phoneNumber) async {
    try {
      final Response response = await BaseHttpClient.postBody(
        'api/v1/users/auth/check_registration/',
        <String, String>{
          'phone_number': phoneNumber,
        },
        haveToken: false,
      );
      log(
        utf8.decode(
          response.bodyBytes,
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('Someting wrong in checkRegistration: $e');
    }
    return false;
  }

  static Future<bool> archiveAccount() async {
    try {
      http.Response response = await BaseHttpClient.getBody(
          'api/v1/users/auth/archive_account/',
          headers: BaseHttpClient.getDefaultHeader());
      log(
        utf8.decode(
          response.bodyBytes,
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('Someting wrong in checkRegistration: $e');
    }
    return false;
  }

  static Future<String?> login(String phoneNumber, String code) async {
    final Response response = await http.post(
      Uri.parse(
        '${baseUrl}api/v1/users/auth/login/',
      ),
      body: jsonEncode(
        <String, String>{
          'phone_number': phoneNumber,
          'verification_code': code,
        },
      ),
      headers: BaseHttpClient.getDefaultHeader(
        haveToken: false,
      ),
    );
    if (response.statusCode == 403) {
      final Map<String, dynamic> body = Map<String, dynamic>.from(
        jsonDecode(response.body) as Map,
      );
      await saveUserInfo(body);
      if (body['status'] == 1) {
        return RoutesNames.catalog;
      }
      if (body['status'] == 2) {
        return RoutesNames.contactInfo;
      }
    } else if (response.statusCode < 300) {
      try {
        final Map<String, dynamic> body = Map<String, dynamic>.from(
          jsonDecode(response.body) as Map,
        );
        await saveUserInfo(body);
        log(
          jsonDecode(
                utf8.decode(
                  response.bodyBytes,
                ),
              )['message'] ??
              '',
        );
        return RoutesNames.menu;
      } catch (e) {
        log('Someting wrong in login: $e');
      }
    }
    return null;
  }

  static Future<bool> verify(
    String phoneNumber,
    String code,
  ) async {
    final Response? response = await BaseHttpClient.post(
      'api/v1/users/auth/verify/',
      <String, String>{
        'phone_number': phoneNumber,
        'verification_code': code,
      },
      haveToken: false,
    );
    if (response != null) {
      try {
        saveClientId(
          jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          ),
        );
        log(
          jsonDecode(
                utf8.decode(
                  response.bodyBytes,
                ),
              )['message'] ??
              '',
        );

        return true;
      } catch (e) {
        log('Someting wrong in verify: $e');
      }
    }
    return false;
  }

  static Future<bool> incrementInvites(
    String phoneNumber,
    String userName,
  ) async {
    try {
      final Response? response = await BaseHttpClient.post(
        'api/v1/users/auth/increment_invites/',
        <String, String>{
          'phone_number': phoneNumber,
          'invited_by_username': userName,
        },
        haveToken: false,
      );
      if (response != null) {
        final Map<String, dynamic> body = Map<String, dynamic>.from(
          jsonDecode(response.body) as Map,
        );
        await saveUserInfo(
          body,
        );
        log(
          jsonDecode(
            utf8.decode(
              response.bodyBytes,
            ),
          ).toString(),
        );

        return true;
      }
    } catch (e) {
      log('Someting wrong in incrementInvites: $e');
      return false;
    }
    return false;
  }

  static Future<bool> memberShip(
    String phoneNumber,
    MembershipType type,
  ) async {
    final String? response = await BaseHttpClient.put(
      'api/v1/users/user/membership/',
      <String, String>{
        'phone_number': phoneNumber,
        'membership_level': type.name,
      },
    );
    log(response.toString());
    if (response != null) return true;
    return false;
  }

  static dynamic saveUserName(
    Map<String, dynamic> body,
  ) async {
    final Box box = Hive.box(HiveStrings.userBox);
    await box.put(
      HiveStrings.username,
      body['username'],
    );
  }

  static dynamic saveClientId(
    Map<String, dynamic> body,
  ) async {
    if (body['user_id'] != null) {
      final Box box = Hive.box(HiveStrings.userBox);
      await box.put(
        HiveStrings.id,
        body['user_id'],
      );
    }
  }

  static dynamic saveUserInfo(
    Map<String, dynamic> body,
  ) async {
    try {
      final Box box = Hive.box(HiveStrings.userBox);

      await box.put(
        HiveStrings.id,
        body['user_id'],
      );
      await box.put(
        HiveStrings.token,
        body['access_token'],
      );
      await box
          .put(
            HiveStrings.refreshToken,
            body['refresh_token'],
          )
          .then((void value) => log('Saved the user info'));
    } catch (e) {
      log('Someting wrong in saveUserInfo: $e');
    }
  }

  static Future<UserModel?> editUser({
    String? firstName,
    String? lastName,
    String? middleName,
  }) async {
    try {
      final dynamic response = await BaseHttpClient.patch(
        'api/v1/users/verify-identity/',
        <String, String?>{
          'first_name': firstName,
          'last_name': lastName,
          'middle_name': middleName,
        },
      );
      await saveUserName(
        jsonDecode(
          utf8.decode(
            response,
          ),
        ),
      );
      return UserModel.fromMap(
        jsonDecode(
          utf8.decode(
            response,
          ),
        ),
      );
    } catch (e) {
      log('Someting wrong in editUser: $e');
    }
    return null;
  }

  static Future<UserModel?> verifyIdentity(
    String firstName,
    String lastName,
    String middleName,
    String userName,
    String dateOfBirth,
    BuildContext context,
  ) async {
    try {
      final DateTime date = DateFormat('dd-MM-yyyy').parse(
        dateOfBirth,
      );
      final Response? response = await BaseHttpClient.putResponse(
          'api/v1/users/verify-identity/',
          middleName != ''
              ? <String, String>{
                  'first_name': firstName,
                  'last_name': lastName,
                  'middle_name': middleName,
                  'username': userName,
                  'date_of_birth': DateFormat('yyyy-MM-dd').format(date),
                }
              : <String, String>{
                  'first_name': firstName,
                  'last_name': lastName,
                  'username': userName,
                  'date_of_birth': DateFormat('yyyy-MM-dd').format(date),
                }, onError: (Response response) {
        if (context.mounted) {
          showLoginErrorSnackbar(
            context,
            response,
          );
        }
      });
      if (response != null) {
        log(
          utf8.decode(
            response.bodyBytes,
          ),
        );
        try {
          await saveUserName(
            jsonDecode(
              utf8.decode(
                response.bodyBytes,
              ),
            ),
          );
          return UserModel.fromMap(
            jsonDecode(
              utf8.decode(
                response.bodyBytes,
              ),
            ),
          );
        } catch (e) {
          log('Someting wrong in verifyIdentity while parsing: $e');
        }
      }
    } catch (e) {
      log('Someting wrong in verifyIdentity: $e');
    }
    return null;
  }

  static Future<void> changePhone(String phone) async {
    final Response? response = await BaseHttpClient.post(
      'api/v1/users/auth/change_phone_number/',
      <String, String>{
        'phone_number': phone,
      },
      haveToken: false,
    );
    if (response != null) {
      try {
        log(
          jsonDecode(
                utf8.decode(
                  response.bodyBytes,
                ),
              )['message'] ??
              '',
        );
      } catch (e) {
        log('Someting wrong in changePhone: $e');
        return;
      }
    } else {
      return;
    }
  }
}
