part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => <Object>[];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final Stream<dynamic> messages;

  const ChatSuccess({required this.messages});
}

class ChatErrror extends ChatState {
  String get message => 'Error';
}
