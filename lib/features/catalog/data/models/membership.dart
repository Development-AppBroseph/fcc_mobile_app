class MembershipModel {
  final int id;
  final String level;
  final double price;
  MembershipModel({
    required this.id,
    required this.level,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'level': level,
      'price': price,
    };
  }

  factory MembershipModel.fromMap(Map<String, dynamic> map) {
    return MembershipModel(
      id: map['id'] as int,
      level: map['level'] as String,
      price: double.tryParse(map['price']) ?? 300,
    );
  }
}
