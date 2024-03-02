class CurrentMembership {
  int? id;
  int? client;
  Membership? membership;
  String? startDate;
  String? endDate;
  bool? isActive;

  CurrentMembership({
    this.id,
    this.client,
    this.membership,
    this.startDate,
    this.endDate,
    this.isActive,
  });

  CurrentMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    membership = json['membership'] != null
        ? Membership.fromJson(json['membership'])
        : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client'] = client;
    if (membership != null) {
      data['membership'] = membership!.toJson();
    }
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['is_active'] = isActive;
    return data;
  }
}

class Membership {
  int? id;
  String? level;
  String? price;
  String? name;

  Membership({
    this.id,
    this.level,
    this.price,
    this.name,
  });

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}
