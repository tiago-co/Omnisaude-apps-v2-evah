import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/settings/pages/widgets/enabled_notification_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:settings_labels/labels.dart';

class NotificationEnabledPage extends StatefulWidget {
  const NotificationEnabledPage({Key? key}) : super(key: key);

  @override
  State<NotificationEnabledPage> createState() =>
      _NotificationEnabledPageState();
}

class _NotificationEnabledPageState extends State<NotificationEnabledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const NavBarWidget(title: SettingsLabels.notificationEnabledTitle).build(context) as AppBar,
      body: Column(
        children: const [
          EnabledNotificationWidget(
            title: SettingsLabels.notificationEnabledTabSatatus,
          ),
        ],
      ),
    );
  }
}
