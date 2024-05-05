class Address {
  int? id;
  String? address;
  double? latitude;
  double? longitude;

  Address({this.id, this.address, this.latitude, this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return 'Address(id: $id, address: $address, latitude: $latitude, longitude: $longitude)';
  }

  void formatAddress() {
    List<String> parts = address!.split(', ');
    if (parts.length > 1 && parts[0].contains(RegExp(r'^\d{6}$'))) {
      parts.removeAt(0);
      address = parts.join(', ');
    }
  }
}
