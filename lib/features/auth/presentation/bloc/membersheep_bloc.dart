import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/auth/data/models/membership.dart';
import 'package:fcc_app_front/features/auth/data/repositories/auth_repo.dart';

part 'membersheep_event.dart';
part 'membersheep_state.dart';

class MembersheepBloc extends Bloc<MembersheepEvent, MembersheepState> {
  MembersheepBloc() : super(const MembersheepState()) {
    on<GetCurrentMemberSheep>(_getMemberSheep);
  }

  Future<void> _getMemberSheep(
    GetCurrentMemberSheep event,
    Emitter<MembersheepState> emit,
  ) async {
    final CurrentMembership? membersheep =
        await AuthRepo.getCurrentMembership();

    if (membersheep != null) {
      emit(state.copyWith(model: membersheep));
    }
  }
}
