import 'dart:convert';
import 'dart:developer';
import 'package:fcc_app_front/features/chat/data/models/message.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';
import 'package:fcc_app_front/shared/config/utils/get_token.dart';
import 'package:fcc_app_front/shared/constants/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class ChatRepo {
  static Future<int?> getChat() async {
    final box = Hive.box(HiveStrings.userBox);
    if (!box.containsKey(
      HiveStrings.chatId,
    )) {
      final chat = await BaseHttpClient.get('api/v1/support-chats/chats/');
      if (chat == null) return null;
      final id = jsonDecode(
        chat,
      )['id'] as int;
      box.put(
        HiveStrings.chatId,
        id,
      );
      return id;
    } else {
      return box.get(HiveStrings.chatId);
    }
  }

  static Future<MessageModel?> writeMessage(String message) async {
    final chat = await BaseHttpClient.post(
      'api/v1/support-chats/messages/',
      {
        "message": message,
      },
    );
    if (chat == null) return null;
    return MessageModel.fromMap(
      jsonDecode(
        utf8.decode(
          chat.bodyBytes,
        ),
      ),
    );
  }

  static Future<MessageModel?> uploadImage(String path) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://167.99.246.103:8081/api/v1/support-chats/messages/'),
    );
    final token = getToken();
    request.headers.addAll(
      {
        'Authorization': 'Bearer $token',
      },
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        path,
      ),
    );
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    log(
      jsonDecode(
        utf8.decode(
          responseData.bodyBytes,
        ),
      ).toString(),
    );
    if (responseData.statusCode < 300) {
      return MessageModel.fromMap(
        jsonDecode(
          utf8.decode(
            responseData.bodyBytes,
          ),
        ),
      );
    }
    return null;
  }

  static Future<List<MessageModel>> getMessages() async {
    List<MessageModel> messages = [];
    try {
      final response = await BaseHttpClient.get(
        'api/v1/support-chats/messages/',
      );
      if (response != null) {
        final body = jsonDecode(
          response,
        ) as List;
        for (final message in body) {
          messages.add(
            MessageModel.fromMap(
              message,
            ),
          );
        }
      }
      messages.sort(
        (a, b) => a.date.compareTo(
          b.date,
        ),
      );
    } catch (e) {
      log("Couldn't get the messages: $e");
    }
    return messages.reversed.toList();
  }
}
