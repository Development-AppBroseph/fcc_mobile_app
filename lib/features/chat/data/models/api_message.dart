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
}
