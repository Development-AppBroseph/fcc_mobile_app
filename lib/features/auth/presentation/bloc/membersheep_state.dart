part of 'membersheep_bloc.dart';

class MembersheepState extends Equatable {
  final CurrentMembership? model;
  const MembersheepState({
    this.model,
  });
  MembersheepState copyWith({
    CurrentMembership? model,
  }) =>
      MembersheepState(
        model: model ?? this.model,
      );
  @override
  List<Object?> get props => <Object?>[model];
}
