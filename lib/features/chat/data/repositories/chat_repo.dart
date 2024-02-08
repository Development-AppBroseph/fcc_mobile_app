import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class ChatRepository {
  types.Message getMessage();

  void sendMessage(Message message);

  void dispose();
}
