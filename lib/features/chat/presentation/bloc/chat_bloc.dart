import 'dart:async';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo_impl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepositoryImpl _chatRepository;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<FecthAllChatEvent>(_fetchChats);
    on<SendMessage>(_sendMessage);
  }

  Future<void> _fetchChats(
    FecthAllChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    try {
      final Stream messages = _chatRepository.getChats();
      emit(ChatSuccess(messages: messages));
    } catch (e) {
      emit(ChatErrror());
    }
  }

  Future<void> _sendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      _chatRepository.sendMessage(event.message);
    } catch (e) {
      emit(ChatErrror());
    }
  }
}
