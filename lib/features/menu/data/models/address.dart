class Address {
  final int id;
  final String address;

  Address({
    required this.id,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'address': address,
    };
  }

  Address copyWith({
    int? id,
    String? address,
  }) =>
      Address(
        id: id ?? this.id,
        address: address ?? this.address,
      );
}
