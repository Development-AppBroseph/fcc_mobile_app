// import 'dart:io';
// import 'package:fcc_app_front/export.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationApi {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> requestPermissions() async {
//     if (Platform.isIOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     } else if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//           flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();

//       await androidImplementation?.requestNotificationsPermission();
//     }
//   }

//   static Future<void> init() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(Assets.fsc.path);

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//         iOS: DarwinInitializationSettings(),
//       ),
//     );
//     requestPermissions();
//   }

//   static void pushNotification(
//     RemoteMessage message,
//   ) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         const AndroidNotificationDetails(
//       'channed id',
//       'channel name',
//       channelDescription: 'channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher',
//     );
//     DarwinNotificationDetails iOSPlatformChannelSpecifics =
//         const DarwinNotificationDetails();
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     print(message);
//     flutterLocalNotificationsPlugin.show(
//       1,
//       message.data['title'],
//       message.data['body'],
//       platformChannelSpecifics,
//     );
//   }

//   static void pushLocaleNotification(
//     String title,
//     String body,
//   ) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         const AndroidNotificationDetails(
//       'channed id',
//       'channel name',
//       channelDescription: 'channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher',
//     );
//     DarwinNotificationDetails iOSPlatformChannelSpecifics =
//         const DarwinNotificationDetails();
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     flutterLocalNotificationsPlugin.show(
//       1,
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }
// }
