import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/notifications/notifications_repository.dart';
import 'package:omni_core/src/app/modules/notifications/pages/notification_details_page.dart';
import 'package:omni_core/src/app/modules/notifications/pages/notifications_page.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notices_store.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notifications_store.dart';
import 'package:omni_core/src/app/modules/notifications/stores/reminders_store.dart';
import 'package:omni_general/omni_general.dart';

class NotificationsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NoticesStore()),
    Bind.lazySingleton((i) => ReminderStore()),
    Bind.lazySingleton((i) => NotificationsStore()),
    Bind.lazySingleton(
      (i) => NotificationsRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NotificationsPage(userId: args.data),
    ),
    ChildRoute(
      '/notificationDetails',
      child: (_, args) => NotificationDetailsPage(notification: args.data),
    ),
  ];
}
