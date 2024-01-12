import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:flutter/material.dart';
import '../../data/models/user.dart';
import '../../../catalog/data/datasources/catalog.dart';
import '../../../../shared/constants/hive.dart';
import 'package:hive/hive.dart';

import '../../data/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static final box = Hive.box(
    HiveStrings.userBox,
  );
  AuthCubit() : super(Unauthenticated());
  init() async {
    if (box.containsKey(
          HiveStrings.token,
        ) &&
        box.containsKey(
          HiveStrings.username,
        )) {
      final user = await AuthRepo.getUser();
      if (user != null) {
        log('Have user');
        emit(
          Authenticated(
            user: user,
          ),
        );
      }
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
    final user = await AuthRepo.verifyIdentity(
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

  editUser({
    String? firstName,
    String? lastName,
    String? middleName,
  }) async {
    final user = await AuthRepo.editUser(
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

  changePhone(String phone) async {
    await AuthRepo.changePhone(
      phone,
    );
  }

  archiveAccount() {
    final currentState = super.state;
    if (currentState is Authenticated) {
      AuthRepo.archiveAccount(
        currentState.user.phoneNumber,
      );
    }
    box.clear();
    emit(
      Unauthenticated(),
    );
  }

  logOut() {
    box.clear();
    emit(
      Unauthenticated(),
    );
  }

  Future<String?> login(String phone, String code) async {
    try {
      if (await AuthRepo.checkRegistration(phone)) {
        final route = await AuthRepo.login(phone, code);
        if (route == RoutesNames.menu) {
          final user = await AuthRepo.getUser();
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
          return RoutesNames.auth;
        }
      }
    } catch (e) {
      log("Couldn't login: $e");
    }
    return null;
  }

  Future<bool> incrementInvites(String phone, String userName) async {
    return await AuthRepo.incrementInvites(phone, userName);
  }

  Future<bool> createUserSendCode(String phone) async {
    if (await AuthRepo.checkRegistration(phone)) {
      return await AuthRepo.sendSms(phone);
    } else {
      return await AuthRepo.register(phone);
    }
  }

  Future<bool> memberShip(String phone, MembershipType type) async {
    final authState = super.state;
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
