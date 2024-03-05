import 'package:fcc_app_front/export.dart';

part 'fcm_token.g.dart';

@HiveType(typeId: 1)
class FcmToken {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? token;

  FcmToken({
    this.id,
    this.token,
  });

  FcmToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
