import 'dart:convert';

import 'package:fcc_app_front/features/chat/data/models/message_body_model.dart';

class MessageModel {
  final String type;
  final Message message;

  MessageModel({
    required this.type,
    required this.message,
  });

  MessageModel copyWith({
    String? type,
    Message? message,
  }) {
    return MessageModel(
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = <String, dynamic>{};

    result.addAll(<String, dynamic>{'type': type});
    result.addAll(<String, dynamic>{'message': message.toMap()});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      type: map['type'] ?? '',
      message: Message.fromMap(map['message']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() => 'MessageModel(type: $type, message: $message)';
}
