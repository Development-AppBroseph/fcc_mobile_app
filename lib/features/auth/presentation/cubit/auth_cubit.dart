import 'dart:async';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/data/models/membership.dart';
import 'package:fcc_app_front/features/auth/presentation/bloc/membersheep_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final MembersheepBloc membersheepBloc = MembersheepBloc();

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
        membersheepBloc.add(GetCurrentMemberSheep());
        log('Have user');

        emit(
          Authenticated(
            user: user,
          ),
        );
      }
    }
  }

  Future<void> checkServerState() async {
    final bool serverResponse = await AuthRepo.checkServerStatus();
    if (!serverResponse) {
      emit(const ServerNotResponsesState());
    }
  }

  Future<CurrentMembership?> getCurrentMerbership() {
    return AuthRepo.getCurrentMembership();
  }

  Future<bool> checkInviteByLink({
    required String username,
  }) async {
    try {
      final Response response = await BaseHttpClient.getBody(
        inviteUrl + username.toUpperCase(),
      );

      if (response.statusCode == 200) {
        log('Invited by username: ${response.body}');
        return true;
      } else if (response.statusCode == 400) {
        log('Username parameter missing: ${response.body}');
        return false;
      } else if (response.statusCode == 422) {
        log('No user found with provided username: ${response.body}');
        return false;
      } else {
        log('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      log(error.toString());
      return false;
    }
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

  Future<bool> archiveAccount() async {
    final AuthState currentState = super.state;
    if (currentState is Authenticated) {
      AuthRepo.archiveAccount();
    }

    box.clear();
    emit(
      Unauthenticated(),
    );
    if (await AuthRepo.archiveAccount()) {
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
    } else {
      if (await AuthRepo.register(phone)) {
        return (true, true);
      }
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
            userName: authState.user.userName,
            membership: type.name,
          ),
        ),
      );
      return true;
    }
    return false;
  }
}
