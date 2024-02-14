import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/features/chat/data/models/message.dart';
import 'package:fcc_app_front/features/chat/data/models/message_body_model.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRepositoryImpl implements ChatRepository {
  final WebSocketChannel _channel;
  final Box<MessageModel> _messageBox;

  ChatRepositoryImpl(this._channel, this._messageBox);

  void saveMessageToStorage(MessageModel message) async {
    try {
      await _messageBox.add(message);
    } catch (e) {
      log('Error saving message to storage: $e');
    }
  }

  @override
  void dispose() {
    try {
      _channel.sink.close();
    } catch (e) {
      log('Error closing WebSocket: $e');
    }
  }

  @override
  types.Message getMessage() {
    // TODO: implement getMessage
    throw UnimplementedError();
  }

  @override
  void sendMessage(Message message) {
    // TODO: implement sendMessage
  }
}

class WebSocketException implements Exception {
  final String message;

  WebSocketException({required this.message});

  @override
  String toString() => message;
}
