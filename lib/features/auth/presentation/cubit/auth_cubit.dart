import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static final Box box = Hive.box(
    HiveStrings.userBox,
  );
  AuthCubit() : super(Unauthenticated());
  void init() async {
    if (box.containsKey(
          HiveStrings.token,
        ) &&
        box.containsKey(
          HiveStrings.username,
        )) {
      final UserModel? user = await AuthRepo.getUser();
      if (user != null) {
        log('Have user');

        emit(Authenticated(
          user: user,
        ).copyWith(
          user: user,
        ));
      }
    }
  }

  Future<UserModel?> getUserSession() async {
    final UserModel? user = await AuthRepo.getUser();
    return user;
  }

  Future<String?> checkInviteByLink({required String username}) async {
    try {
      final Response response = await BaseHttpClient.getBody(inviteUrl,
          queryParameters: <String, String>{'invite': username});
      if (response.statusCode == 200) {
        return null;
      } else {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String detailMessage =
            responseBody['detail'] ??
                'Произошла ошибка, попробуйте позже еще раз';

        return _decodeInvalidEncoding(detailMessage);
      }
    } catch (error) {
      log(error.toString());
      return error.toString();
    }
  }

  String _decodeInvalidEncoding(String input) {
    // Decode the Windows-1252 encoded bytes as UTF-8
    List<int> bytes = input.runes.toList();
    return utf8.decode(bytes);
  }

  Future<bool> verifyIdentity(
    String firstName,
    String lastName,
    String middleName,
    String userName,
    String dateOfBirth,
    BuildContext context,
  ) async {
    final UserModel? user = await AuthRepo.verifyIdentity(
      firstName,
      lastName,
      middleName,
      userName,
      dateOfBirth,
      context,
    );
    if (user != null) {
      emit(
        Authenticated(
          user: user,
        ),
      );
      return true;
    }
    return false;
  }

  void editUser({
    String? firstName,
    String? lastName,
    String? middleName,
  }) async {
    final UserModel? user = await AuthRepo.editUser(
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
    );
    if (user != null) {
      emit(
        Authenticated(
          user: user,
        ),
      );
    }
  }

  void changePhone(String phone) async {
    await AuthRepo.changePhone(
      phone,
    );
  }

  Future<bool> deleteAccaunt() async {
    final AuthState currentState = super.state;
    if (currentState is Authenticated) {
      AuthRepo.deleteAccount();
    }

    box.clear();
    emit(
      Unauthenticated(),
    );
    if (await AuthRepo.deleteAccount()) {
      return true;
    } else {
      return false;
    }
  }

  void logOut() {
    box.clear();
    emit(
      Unauthenticated(),
    );
  }

  Future<String?> login(
    String phone,
    String code,
  ) async {
    try {
      if (await AuthRepo.checkRegistration(phone)) {
        final String? route = await AuthRepo.login(phone, code);
        if (route == RoutesNames.menu) {
          final UserModel? user = await AuthRepo.getUser();
          if (user != null) {
            emit(
              Authenticated(
                user: user,
              ),
            );
            log('Logged in user');
            return RoutesNames.menu;
          }
        }
        return route;
      } else {
        if (await AuthRepo.verify(phone, code)) {
          return RoutesNames.introCatalog;
        }
      }
    } catch (e) {
      log("Couldn't login: $e");
    }
    return null;
  }

  Future<bool> incrementInvites(
    String phone,
    String userName,
  ) async {
    return await AuthRepo.incrementInvites(phone, userName);
  }

  Future<(bool, bool)> createUserSendCode(String phone) async {

    if (await AuthRepo.checkRegistration(phone)) {
      return (await AuthRepo.sendSms(phone), false);
    }
    if (await AuthRepo.register(phone)) {
      return (true, true);
    }
    return (false, false);
  }

  Future<bool> memberShip(
    String phone,
    MembershipType type,
  ) async {
    final AuthState authState = super.state;
    if (authState is Authenticated) {
      emit(
        Authenticated(
          user: UserModel(
            firstName: authState.user.firstName,
            lastName: authState.user.lastName,
            middleName: authState.user.middleName,
            phoneNumber: authState.user.phoneNumber,
            membershipLevel: type.name,
          ),
        ),
      );
      return true;
    }
    return false;
  }
}
