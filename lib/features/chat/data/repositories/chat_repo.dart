import 'package:fcc_app_front/export.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class ChatRepository {
  types.Message getMessage();

  void sendMessage(Message message);

  void dispose();
}
