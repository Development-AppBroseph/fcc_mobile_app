class MessageModel {
  final int id;
  final bool isMine;
  final String? message;
  final String? image;
  final DateTime date;
  MessageModel({
    required this.id,
    required this.isMine,
    this.message,
    this.image,
    required this.date,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as int,
      isMine: map['sender'] == 'Client',
      message: map['message'] ?? '',
      image: map['image'],
      date: DateTime.parse(
        map['created_at'] as String,
      ),
    );
  }
}
