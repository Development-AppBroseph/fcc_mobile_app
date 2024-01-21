import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class FirebaseNotificationsRepo {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future initNotifications(Function onBackgroundMessage) async {
    await _firebaseMessaging.requestPermission();
    log(await _firebaseMessaging.getToken() ?? '');
    try {
      FirebaseMessaging.onBackgroundMessage(
        (RemoteMessage message) async {
          log(message.data.toString());
          NotificationApi.pushNotification(message);
          onBackgroundMessage();
        },
      );
    } catch (e) {
      log('FirebaseMessaging.onBackgroundMessage error: $e');
    }
    try {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          log(message.data.toString());
          NotificationApi.pushNotification(message);

          onBackgroundMessage();
        },
      );
    } catch (e) {
      log('FirebaseMessaging.onMessage error: $e');
    }
  }

  sendFcm() async {
    final Box box = await Hive.openBox(HiveStrings.userBox);
    try {
      if (!box.containsKey(HiveStrings.isFcmSent)) {
        final Response response = await BaseHttpClient.postBody(
          'api/v1/notifications/fcm_token_create/',
          <String, String?>{
            'token': await _firebaseMessaging.getToken(),
          },
        );
        if (response.statusCode < 300) {
          box.put(
            HiveStrings.isFcmSent,
            true,
          );
        }
      }
    } catch (e) {
      log("Couldn't send fcm: $e");
    }
  }
}
