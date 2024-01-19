import 'package:fcc_app_front/export.dart';

String? getToken() {
  final Box userBox = Hive.box(HiveStrings.userBox);
  if (userBox.containsKey(HiveStrings.token)) {
    return userBox.get(HiveStrings.token);
  }
  return null;
}

int? getClientId() {
  final Box userBox = Hive.box(HiveStrings.userBox);
  if (userBox.containsKey(HiveStrings.id)) {
    return userBox.get(HiveStrings.id) as int?;
  }
  return null;
}

saveClientId(int? id) {
  Hive.box(HiveStrings.userBox).put(
    HiveStrings.id,
    id,
  );
}
