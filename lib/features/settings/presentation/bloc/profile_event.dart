part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

final class ChangeProfileDetails extends ProfileEvent {
  final String name;
  final String surname;
  final String middlename;
  const ChangeProfileDetails({
    required this.name,
    required this.surname,
    required this.middlename,
  });
}
