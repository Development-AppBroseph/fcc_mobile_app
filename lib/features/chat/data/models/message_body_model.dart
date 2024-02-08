import 'dart:convert';

class Message {
  final String message;
  final dynamic photo; // Assuming photo can be of any type
  final bool clientSend;

  Message({
    required this.message,
    required this.photo,
    required this.clientSend,
  });

  // ... other methods

  Message copyWith({
    String? message,
    dynamic photo,
    bool? clientSend,
  }) {
    return Message(
      message: message ?? this.message,
      photo: photo ?? this.photo,
      clientSend: clientSend ?? this.clientSend,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = <String, dynamic>{};

    result.addAll(<String, dynamic>{'message': message});
    result.addAll(<String, dynamic>{'photo': photo});
    result.addAll(<String, dynamic>{'clientSend': clientSend});

    return result;
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] ?? '',
      photo: map['photo'],
      clientSend: map['client_send'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

  @override
  String toString() => 'Message(message: $message, photo: $photo, clientSend: $clientSend)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message && other.message == message && other.photo == photo && other.clientSend == clientSend;
  }

  @override
  int get hashCode => message.hashCode ^ photo.hashCode ^ clientSend.hashCode;
}
