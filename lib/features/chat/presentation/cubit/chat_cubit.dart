import 'package:bloc/bloc.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo.dart';
import '../../data/models/message.dart';

class ChatCubit extends Cubit<List<MessageModel>> {
  ChatCubit() : super([]);
  load() async {
    var messages = await ChatRepo.getMessages();
    if (messages.isNotEmpty) {
      messages.insert(
        messages.length - 1,
        MessageModel(
          id: -1,
          isMine: false,
          date: messages.last.date,
          message: "Support",
        ),
      );
    }
    emit(
      messages,
    );
  }

  addMessage(String text) async {
    final message = await ChatRepo.writeMessage(text);
    if (message == null) return;
    if (super.state.isEmpty) {
      emit(
        [
          message,
          MessageModel(
            id: -1,
            isMine: false,
            date: message.date,
            message: "Support",
          ),
          ...super.state,
        ],
      );
    } else {
      emit(
        [
          message,
          ...super.state,
        ],
      );
    }
  }

  uploadImage(String path) async {
    final message = await ChatRepo.uploadImage(path);
    if (message == null) return;
    emit(
      [
        message,
        ...super.state,
      ],
    );
  }
}
