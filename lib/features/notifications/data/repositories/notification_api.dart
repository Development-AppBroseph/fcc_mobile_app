import 'dart:math';

import 'package:fcc_app_front/export.dart';

class NotificationApi {
  static final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();

  static void init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/notification'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  static pushNotification(
    RemoteMessage message,
  ) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channed id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _notification.show(
      Random().nextInt(100000000),
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }
}
