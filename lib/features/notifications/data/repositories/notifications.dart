import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class FirebaseNotificationsRepo {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications(Function onBackgroundMessage) async {
    await _firebaseMessaging.requestPermission();
    log('firebase token:${await _firebaseMessaging.getToken()}');
    final String? token = await _firebaseMessaging.getToken();
    Hive.box(HiveStrings.isFcmSent).put(HiveStrings.isFcmSent, token);

    try {
      FirebaseMessaging.onBackgroundMessage(
        (RemoteMessage message) async {
          log(message.data.toString());

          NotificationApi.pushNotification(message);
          onBackgroundMessage();
        },
      );

      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      log('FirebaseMessaging.onBackgroundMessage error: $e');
    }
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          log('Here is from onMessageOpenedApp${message.data}');
          NotificationApi.pushNotification(message);
        },
      );

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          log('Hefre is onMessage$message');
          NotificationApi.pushNotification(message);

          onBackgroundMessage();
        },
      );
    } catch (e) {
      log('FirebaseMessaging.onMessage error: $e');
    }
  }
}
