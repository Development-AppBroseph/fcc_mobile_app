part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => <Object>[];
}

class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSucces extends ProfileState {}

final class ProfileError extends ProfileState {
  final String error;

  const ProfileError({required this.error});
}
