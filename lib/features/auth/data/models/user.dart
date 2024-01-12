import 'package:fcc_app_front/shared/config/utils/get_token.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String middleName;
  final String phoneNumber;
  final String? membership;
  final String userName;
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.phoneNumber,
    this.membership,
    required this.userName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, {String? phoneNumber}) {
    saveClientId(
      map['id'],
    );
    return UserModel(
      firstName: map['first_name'] ?? '',
      userName: map['username'] ?? '',
      lastName: map['last_name'] ?? '',
      middleName: map['middle_name'] ?? '',
      phoneNumber: phoneNumber ?? map['phone_number'] ?? '',
      membership: map['membership_level'],
    );
  }
}
