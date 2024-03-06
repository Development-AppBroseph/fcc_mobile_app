part of 'server_bloc.dart';

abstract class ServerState extends Equatable {
  const ServerState();

  @override
  List<Object> get props => <Object>[];
}

class ServerOnline extends ServerState {}

class ServerOffline extends ServerState {}
