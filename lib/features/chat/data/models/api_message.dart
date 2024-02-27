class ApiMessage {
  int? id;
  String? message;
  bool? clientSend;
  String? file;
  String? created_date;
  String? updated_date;
  String? type;

  ApiMessage({
    this.type,
    this.id,
    this.message,
    this.clientSend,
    this.file,
    this.created_date,
    this.updated_date,
  });

  ApiMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    message = json['message'];
    clientSend = json['client_send'];
    file = json['file'];
    created_date = json['created_date'];
    updated_date = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['message'] = message;
    data['client_send'] = clientSend;
    data['file'] = file;
    data['created_date'] = created_date;
    data['updated_date'] = updated_date;
    return data;
  }

  ApiMessage copyWith({
    int? id,
    String? type,
    String? message,
    bool? clientSend,
    String? file,
    String? created_date,
    String? updated_date,
  }) {
    return ApiMessage(
      type: type ?? this.type,
      id: id ?? this.id,
      message: message ?? this.message,
      clientSend: clientSend ?? this.clientSend,
      file: file ?? this.file,
      created_date: created_date ?? this.created_date,
      updated_date: updated_date ?? this.updated_date,
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
    if (file != null) {
      result.addAll(<String, dynamic>{'file': file});
    }
    if (created_date != null) {
      result.addAll(<String, dynamic>{'created_date': created_date});
    }
    if (updated_date != null) {
      result.addAll(<String, dynamic>{'updated_date': updated_date});
    }

    return result;
  }

  factory ApiMessage.fromMap(Map<String, dynamic> map) {
    return ApiMessage(
      id: map['id']?.toInt(),
      type: map['type'],
      message: map['message'],
      clientSend: map['client_send'],
      file: map['file'],
      created_date: map['created_date'],
      updated_date: map['updated_date'],
    );
  }

  @override
  String toString() {
    return 'ApiMessage(id: $id, message: $message, clientSend: $clientSend, file: $file, created_date: $created_date, updated_date: $updated_date,type: $type)';
  }
}
