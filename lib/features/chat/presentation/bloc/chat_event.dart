part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => <Object>[];
}

final class FecthAllChatEvent extends ChatEvent {}

final class SendMessage extends ChatEvent {
  final MessageModel message;

  const SendMessage({required this.message});
}

final class OpenFileEvent {}
