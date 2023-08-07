import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notices_list_widget.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notifications_list_widget.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/reminder_list_widget.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notifications_store.dart';
import 'package:omni_general/omni_general.dart' show NavBarWidget;

class NotificationsPage extends StatefulWidget {
  final String userId;
  const NotificationsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsStore store = Modular.get();
  final ScrollController noticeController = ScrollController();
  final ScrollController reminderController = ScrollController();
  final ScrollController notificationController = ScrollController();

  @override
  void initState() {
    store.noticesStore.params.limit = '10';
    store.noticesStore.getNotices(store.noticesStore.params);

    noticeController.addListener(() {
      if (noticeController.offset ==
              noticeController.position.maxScrollExtent &&
          store.noticesStore.state.results!.length !=
              store.noticesStore.state.count) {
        store.noticesStore.params.limit =
            (int.parse(store.noticesStore.params.limit!) + 10).toString();
        store.noticesStore.getNotices(store.noticesStore.params);
      }
    });

    store.listenNotification(widget.userId);
    store.reminderStore.listenReminder(widget.userId);

    super.initState();
  }

  @override
  void dispose() {
    noticeController.dispose();
    reminderController.dispose();
    notificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: NotificationsLabels.notificationsTitle,
      ).build(context) as AppBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                shadowColor: Colors.transparent,
              ),
              child: RefreshIndicator(
                displacement: 0,
                strokeWidth: 0.75,
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.background,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  store.noticesStore.getNotices(store.noticesStore.params);
                  store.reminderStore.listenReminder(widget.userId);
                  store.listenNotification(widget.userId);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              NoticesListWidget(
                                noticeController: noticeController,
                              ),
                              const SizedBox(height: 10),
                              ReminderListWidget(
                                reminderController: reminderController,
                              ),
                              const SizedBox(height: 10),
                              NotificationListWidget(
                                notificationController: notificationController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
