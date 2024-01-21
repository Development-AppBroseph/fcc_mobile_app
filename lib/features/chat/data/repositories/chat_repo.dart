import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:http/http.dart' as http;

class ChatRepo {
  static Future<int?> getChat() async {
    final Box box = Hive.box(HiveStrings.userBox);
    if (!box.containsKey(
      HiveStrings.chatId,
    )) {
      final String? chat = await BaseHttpClient.get('api/v1/support-chats/chats/');
      if (chat == null) return null;
      final int id = jsonDecode(
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
    final http.Response? chat = await BaseHttpClient.post(
      'api/v1/support-chats/messages/',
      <String, String>{
        'message': message,
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
    final http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse('http://167.99.246.103:8081/api/v1/support-chats/messages/'),
    );
    final String? token = getToken();
    request.headers.addAll(
      <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        path,
      ),
    );
    http.StreamedResponse response = await request.send();
    http.Response responseData = await http.Response.fromStream(response);
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
    List<MessageModel> messages = <MessageModel>[];
    try {
      final String? response = await BaseHttpClient.get(
        'api/v1/support-chats/messages/',
      );
      if (response != null) {
        final List body = jsonDecode(
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
        (MessageModel a, MessageModel b) => a.date.compareTo(
          b.date,
        ),
      );
    } catch (e) {
      log("Couldn't get the messages: $e");
    }
    return messages.reversed.toList();
  }
}
