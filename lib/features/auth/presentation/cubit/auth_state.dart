part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => <Object>[];
}

final class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({
    required this.user,
  });

  Authenticated copyWith({
    UserModel? user,
  }) {
    return Authenticated(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => <Object>[
        user,
      ];
}
