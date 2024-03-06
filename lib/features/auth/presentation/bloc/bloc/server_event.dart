part of 'server_bloc.dart';

abstract class ServerEvent extends Equatable {
  const ServerEvent();

  @override
  List<Object> get props => <Object>[];
}

final class CheckServerEvent extends ServerEvent {
  const CheckServerEvent();

  @override
  List<Object> get props => <Object>[];

  @override
  String toString() => 'CheckServerState';
}
