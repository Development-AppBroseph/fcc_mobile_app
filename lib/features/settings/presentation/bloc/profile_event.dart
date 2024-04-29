part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

final class ChangeProfileDetails extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  const ChangeProfileDetails({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.middleName,
  });
}
