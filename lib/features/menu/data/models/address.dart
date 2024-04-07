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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  @override
  String toString() {
    return 'Address(id: $id, address: $address, latitude: $latitude, longitude: $longitude)';
  }
}
