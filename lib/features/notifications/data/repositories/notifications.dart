import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:html' as web;

class FirebaseNotificationsRepo {
// use the returned token to send messages to users from your custom server

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications(Function onBackgroundMessage) async {
    await _firebaseMessaging.requestPermission();
    final String? token = await _firebaseMessaging.getToken(
      vapidKey:
          'BKcykRrAxRkMX5lgT7WusnUc4aOYg4qiqfzJ9knJh_D_AdBUFJxUjNlqUxbChiETHOqlknHVSgbsUhGuzbYagQ4',
    );

    log('firebase token:$token');

    Hive.box(HiveStrings.isFcmSent).put(HiveStrings.isFcmSent, token);

    try {
      FirebaseMessaging.onBackgroundMessage(
        (RemoteMessage message) async {
          log(message.data.toString());

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
          //  NotificationApi.pushNotification(message);
        },
      );

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          log('Hefre is onMessage$message');
          showNotification(
            message.data['body'],
          );
        },
      );
    } catch (e) {
      log('FirebaseMessaging.onMessage error: $e');
    }
  }
}

Future<void> showNotification(String message) async {
  String? permission = web.Notification.permission;
  if (permission != 'granted') {
    permission = await web.Notification.requestPermission();
  }
  if (permission == 'granted') {
    web.Notification(message);
  }
}
