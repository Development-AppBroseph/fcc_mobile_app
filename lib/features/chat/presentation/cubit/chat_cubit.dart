import 'package:fcc_app_front/export.dart';

class ChatCubit extends Cubit<List<MessageModel>> {
  ChatCubit() : super(<MessageModel>[]);
  load() async {
    List<MessageModel> messages = await ChatRepo.getMessages();
    if (messages.isNotEmpty) {
      messages.insert(
        messages.length - 1,
        MessageModel(
          id: -1,
          isMine: false,
          date: messages.last.date,
          message: 'Support',
        ),
      );
    }
    emit(
      messages,
    );
  }

  Future<void> addMessage(String text) async {
    final MessageModel? message = await ChatRepo.writeMessage(text);
    if (message == null) return;
    if (super.state.isEmpty) {
      emit(
        <MessageModel>[
          message,
          MessageModel(
            id: -1,
            isMine: false,
            date: message.date,
            message: 'Support',
          ),
          ...super.state,
        ],
      );
    } else {
      emit(
        <MessageModel>[
          message,
          ...super.state,
        ],
      );
    }
  }

  Future<void> uploadImage(String path) async {
    final MessageModel? message = await ChatRepo.uploadImage(path);
    if (message == null) return;
    emit(
      <MessageModel>[
        message,
        ...super.state,
      ],
    );
  }
}
