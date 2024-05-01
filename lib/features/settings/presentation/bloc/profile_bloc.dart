import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/settings/data/datasources/repository/profile_repository_impl.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepositoryImpl profileRepositoryImpl = ProfileRepositoryImpl();

  ProfileBloc() : super(ProfileInitial()) {
    on<ChangeProfileDetails>(_changeUserDetails);
  }

  Future<void> _changeUserDetails(
    ChangeProfileDetails event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await profileRepositoryImpl.changeProfileDetails(
        email: event.email,
        name: event.firstName,
        surname: event.lastName,
        middlename: event.middleName,
      );
      emit(ProfileLoading());
      emit(ProfileSucces());
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}
