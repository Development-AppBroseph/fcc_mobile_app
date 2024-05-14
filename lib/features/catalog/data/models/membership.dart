import 'package:fcc_app_front/export.dart';

class MembershipModel extends Equatable {
  final int id;
  final String level;
  final double price;
  const MembershipModel({
    required this.id,
    required this.level,
    required this.price,
  });

  Map<String, dynamic> toJson() {
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

  @override
  List<Object?> get props => <Object?>[
        id,
        level,
        price,
      ];
}
