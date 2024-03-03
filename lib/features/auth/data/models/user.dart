import 'package:fcc_app_front/shared/config/utils/get_token.dart';

class UserModel {
  int? id;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? middleName;
  bool? isActive;
  bool? isPhoneVerified;
  String? passportVerificationStatus;
  bool? isIdentityVerified;
  String? membershipLevel;
  int? invitedCount;
  String? invitationCode;
  String? sumDiscount;
  UserMembership? userMembership;

  UserModel(
      {this.id,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.middleName,
      this.isActive,
      this.isPhoneVerified,
      this.passportVerificationStatus,
      this.isIdentityVerified,
      this.membershipLevel,
      this.invitedCount,
      this.invitationCode,
      this.sumDiscount,
      this.userMembership});

  UserModel.fromJson(Map<String, dynamic> json) {
    saveClientId(
      json['id'],
    );
    phoneNumber = json['phone_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    isActive = json['is_active'];
    isPhoneVerified = json['is_phone_verified'];
    passportVerificationStatus = json['passport_verification_status'];
    isIdentityVerified = json['is_identity_verified'];
    membershipLevel = json['membership_level'];
    invitedCount = json['invited_count'];
    invitationCode = json['invitation_code'];
    sumDiscount = json['sum_discount'];
    userMembership = json['user_membership'] != null
        ? UserMembership.fromJson(json['user_membership'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone_number'] = phoneNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['is_active'] = isActive;
    data['is_phone_verified'] = isPhoneVerified;
    data['passport_verification_status'] = passportVerificationStatus;
    data['is_identity_verified'] = isIdentityVerified;
    data['membership_level'] = membershipLevel;
    data['invited_count'] = invitedCount;
    data['invitation_code'] = invitationCode;
    data['sum_discount'] = sumDiscount;
    if (userMembership != null) {
      data['user_membership'] = userMembership!.toJson();
    }
    return data;
  }
}

class UserMembership {
  int? id;
  int? client;
  Membership? membership;
  String? startDate;
  String? endDate;
  bool? isActive;

  UserMembership(
      {this.id,
      this.client,
      this.membership,
      this.startDate,
      this.endDate,
      this.isActive});

  UserMembership.fromJson(Map<String, dynamic> json) {
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

  Membership({this.id, this.level, this.price, this.name});

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
