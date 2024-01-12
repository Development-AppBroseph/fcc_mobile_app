import 'dart:developer';

import 'package:fcc_app_front/features/notifications/data/repositories/notification_api.dart';
import 'package:fcc_app_front/shared/config/base_http_client.dart';
import 'package:fcc_app_front/shared/constants/hive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';

class FirebaseNotificationsRepo {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future initNotifications(Function onBackgroundMessage) async {
    await _firebaseMessaging.requestPermission();
    log(await _firebaseMessaging.getToken() ?? '');
    try {
      FirebaseMessaging.onBackgroundMessage(
        (message) async {
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
        (message) {
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
    final box = await Hive.openBox(HiveStrings.userBox);
    try {
      if (!box.containsKey(HiveStrings.isFcmSent)) {
        final response = await BaseHttpClient.postBody(
          'api/v1/notifications/fcm_token_create/',
          {
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
