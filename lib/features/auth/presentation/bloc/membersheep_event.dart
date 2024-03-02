part of 'membersheep_bloc.dart';

abstract class MembersheepEvent extends Equatable {
  const MembersheepEvent();

  @override
  List<Object> get props => <Object>[];
}

final class GetCurrentMemberSheep extends MembersheepEvent {}
