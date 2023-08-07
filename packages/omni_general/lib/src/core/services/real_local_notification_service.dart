import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RealLocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.omni_core',
      'omni_core',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'com.omni_core',
          'omni_core',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      );
      await _notificationsPlugin.show(
        message.notification!.hashCode,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
      log('Notification: ${message.notification!.title}');
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
