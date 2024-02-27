class MessageModel {
  final String type;
  final Message message;

  MessageModel({
    required this.type,
    required this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      type: json['type'],
      message: Message.fromJson(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': type,
      'message': message.toJson(),
    };
  }

  MessageModel copyWith({
    String? type,
    Message? message,
  }) =>
      MessageModel(
        type: type ?? this.type,
        message: message ?? this.message,
      );
}

class Message {
  final int? id;
  final String? message;
  final dynamic file;
  final bool clientSend;
  final String type;
  final DateTime createdDate;
  final DateTime updatedDate;

  Message({
    this.id,
    required this.message,
    required this.file,
    required this.clientSend,
    required this.type,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      file: json['file'],
      clientSend: json['client_send'],
      type: json['type'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'file': file,
      'client_send': clientSend,
      'type': type,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }

  Message copyWith({
    int? id,
    String? message,
    dynamic file,
    bool? clientSend,
    String? type,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) =>
      Message(
        id: id ?? this.id,
        message: message ?? this.message,
        file: file ?? this.file,
        clientSend: clientSend ?? this.clientSend,
        type: type ?? this.type,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );
}
