import 'package:fcc_app_front/shared/constants/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

saveNotificationSettings({
  bool? receiveNotifications,
  bool? pushNotifications,
  bool? smsNotifications,
}) {
  final Box box = Hive.box(HiveStrings.userBox);
  if (receiveNotifications != null) {
    box.put(
      HiveStrings.receiveNotifications,
      receiveNotifications,
    );
  }
  if (pushNotifications != null) {
    box.put(
      HiveStrings.pushNotifications,
      pushNotifications,
    );
  }
  if (smsNotifications != null) {
    box.put(
      HiveStrings.smsNotifications,
      smsNotifications,
    );
  }
}

bool getReceiveNotifications() {
  final Box box = Hive.box(HiveStrings.userBox);
  return box.get(HiveStrings.receiveNotifications) ?? false;
}

bool getPushNotifications() {
  final Box box = Hive.box(HiveStrings.userBox);
  return box.get(HiveStrings.pushNotifications) ?? false;
}

bool getSmsNotifications() {
  final Box box = Hive.box(HiveStrings.userBox);
  return box.get(HiveStrings.smsNotifications) ?? false;
}
