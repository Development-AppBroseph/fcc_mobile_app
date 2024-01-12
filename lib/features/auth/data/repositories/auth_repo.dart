import 'dart:convert';
import 'dart:developer';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/widgets/login_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../../shared/constants/urls.dart';
import '../models/user.dart';
import '../../../catalog/data/datasources/catalog.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/config/base_http_client.dart';
import '../../../../shared/constants/hive.dart';

class AuthRepo {
  static Future<bool> register(String phoneNumber) async {
    try {
      final response = await BaseHttpClient.post(
        'api/v1/users/auth/register/',
        {
          "phone_number": phoneNumber,
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

  static Future<bool> sendSms(String phoneNumber) async {
    try {
      final response = await BaseHttpClient.post(
        'api/v1/users/auth/send_verification_sms/',
        {
          "phone_number": phoneNumber,
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
      final response = await BaseHttpClient.get(
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
      final response = await BaseHttpClient.postBody(
        'api/v1/users/auth/check_registration/',
        {
          "phone_number": phoneNumber,
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

  static Future<bool> archiveAccount(String phoneNumber) async {
    try {
      final response = await BaseHttpClient.postBody(
        'api/v1/users/auth/archive_account/',
        {
          "phone_number": phoneNumber,
        },
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

  static Future<String?> login(String phoneNumber, String code) async {
    final response = await http.post(
      Uri.parse(
        '${baseUrl}api/v1/users/auth/login/',
      ),
      body: jsonEncode(
        {
          "phone_number": phoneNumber,
          "verification_code": code,
        },
      ),
      headers: BaseHttpClient.getDefaultHeader(
        haveToken: false,
      ),
    );
    if (response.statusCode == 403) {
      final body = Map<String, dynamic>.from(jsonDecode(response.body) as Map);
      await saveUserInfo(body);
      if (body['status'] == 1) {
        return RoutesNames.catalog;
      }
      if (body['status'] == 2) {
        return RoutesNames.contactInfo;
      }
    } else if (response.statusCode < 300) {
      try {
        final body = Map<String, dynamic>.from(jsonDecode(response.body) as Map);
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

  static Future<bool> verify(String phoneNumber, String code) async {
    final response = await BaseHttpClient.post(
      'api/v1/users/auth/verify/',
      {
        "phone_number": phoneNumber,
        "verification_code": code,
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

  static Future<bool> incrementInvites(String phoneNumber, String userName) async {
    try {
      final response = await BaseHttpClient.post(
        'api/v1/users/auth/increment_invites/',
        {
          "phone_number": phoneNumber,
          "invited_by_username": userName,
        },
        haveToken: false,
      );
      if (response != null) {
        final body = Map<String, dynamic>.from(jsonDecode(response.body) as Map);
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

  static Future<bool> memberShip(String phoneNumber, MembershipType type) async {
    final response = await BaseHttpClient.put(
      'api/v1/users/user/membership/',
      {
        "phone_number": phoneNumber,
        "membership_level": type.name,
      },
    );
    log(response.toString());
    if (response != null) return true;
    return false;
  }

  static saveUserName(
    Map<String, dynamic> body,
  ) async {
    final box = Hive.box(HiveStrings.userBox);
    await box.put(
      HiveStrings.username,
      body['username'],
    );
  }

  static saveClientId(
    Map<String, dynamic> body,
  ) async {
    if (body['user_id'] != null) {
      final box = Hive.box(HiveStrings.userBox);
      await box.put(
        HiveStrings.id,
        body['user_id'],
      );
    }
  }

  static saveUserInfo(
    Map<String, dynamic> body,
  ) async {
    try {
      final box = Hive.box(HiveStrings.userBox);

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
          .then((value) => log('Saved the user info'));
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
      final response = await BaseHttpClient.patch(
        'api/v1/users/verify-identity/',
        {
          "first_name": firstName,
          "last_name": lastName,
          "middle_name": middleName,
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
      final date = DateFormat('dd-MM-yyyy').parse(
        dateOfBirth,
      );
      final response = await BaseHttpClient.putResponse(
          'api/v1/users/verify-identity/',
          middleName != ''
              ? {
                  'first_name': firstName,
                  'last_name': lastName,
                  'middle_name': middleName,
                  'username': userName,
                  'date_of_birth': DateFormat('yyyy-MM-dd').format(date),
                }
              : {
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

  static changePhone(String phone) async {
    final response = await BaseHttpClient.post(
      'api/v1/users/auth/change_phone_number/',
      {
        "phone_number": phone,
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
        return null;
      }
    } else {
      return null;
    }
  }
}
