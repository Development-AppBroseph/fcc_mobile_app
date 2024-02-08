import 'dart:convert';

class ApiMessage {
  int? id;
  String? message;
  bool? clientSend;
  String? photo;
  String? createdDate;
  String? updatedDate;

  ApiMessage({
    this.id,
    this.message,
    this.clientSend,
    this.photo,
    this.createdDate,
    this.updatedDate,
  });

  ApiMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    clientSend = json['client_send'];
    photo = json['photo'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['client_send'] = clientSend;
    data['photo'] = photo;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }

  ApiMessage copyWith({
    int? id,
    String? message,
    bool? clientSend,
    String? photo,
    String? createdDate,
    String? updatedDate,
  }) {
    return ApiMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      clientSend: clientSend ?? this.clientSend,
      photo: photo ?? this.photo,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = <String, dynamic>{};

    if (id != null) {
      result.addAll(<String, dynamic>{'id': id});
    }
    if (message != null) {
      result.addAll(<String, dynamic>{'message': message});
    }
    if (clientSend != null) {
      result.addAll(<String, dynamic>{'clientSend': clientSend});
    }
    if (photo != null) {
      result.addAll(<String, dynamic>{'photo': photo});
    }
    if (createdDate != null) {
      result.addAll(<String, dynamic>{'createdDate': createdDate});
    }
    if (updatedDate != null) {
      result.addAll(<String, dynamic>{'updatedDate': updatedDate});
    }

    return result;
  }

  factory ApiMessage.fromMap(Map<String, dynamic> map) {
    return ApiMessage(
      id: map['id']?.toInt(),
      message: map['message'],
      clientSend: map['client_send'],
      photo: map['photo'],
      createdDate: map['createdDate'],
      updatedDate: map['updatedDate'],
    );
  }

  @override
  String toString() {
    return 'ApiMessage(id: $id, message: $message, clientSend: $clientSend, photo: $photo, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiMessage &&
        other.id == id &&
        other.message == message &&
        other.clientSend == clientSend &&
        other.photo == photo &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        clientSend.hashCode ^
        photo.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode;
  }
}
