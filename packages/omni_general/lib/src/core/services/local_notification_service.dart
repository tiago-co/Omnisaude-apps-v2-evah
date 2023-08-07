import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/src/core/models/local_notification_model.dart';
import 'package:rxdart/subjects.dart';

class LocalNotificationService extends Disposable {
  final BehaviorSubject<ReceivedNotificationModel>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotificationModel>();

  Future<void> initNotifications() async {
    final FlutterLocalNotificationsPlugin plugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (
        int? id,
        String? title,
        String? body,
        String? payload,
      ) async {
        didReceiveLocalNotificationSubject.add(
          ReceivedNotificationModel(
            id: id ?? 0,
            title: title ?? '',
            body: body ?? '',
            payload: jsonDecode(payload ?? ''),
          ),
        );
      },
    );
    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );
    await plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: selectNotification,
    );

    await plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    didReceiveLocalNotificationSubject.stream.listen((event) async {
      await _showNotification(plugin, event);
    });
  }

  void selectNotification(NotificationResponse? payload) {
    log('notification payload: $payload');
  }

  Future<void> _showNotification(
    FlutterLocalNotificationsPlugin plugin,
    ReceivedNotificationModel notification,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'com.omni_core',
      'omni_core',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await plugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: jsonEncode(notification.payload),
    );
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
  }
}
