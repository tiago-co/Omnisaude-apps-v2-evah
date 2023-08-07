import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/src/app/core/models/notification_model.dart';
import 'package:omni_general/omni_general.dart';

class NotificationDetailsPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> notification;

  const NotificationDetailsPage({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  _NotificationDetailsPageState createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  final ScrollController scrollController = ScrollController();
  late final NotificationModel notification;

  @override
  void initState() {
    notification = NotificationModel.fromJson(widget.notification.data());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: notification.title ??
            NotificationsLabels.notificationDetailsTitlePlaceholder,
      ).build(context) as AppBar,
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          controller: scrollController,
          child: SafeArea(
            child: Html(
              data: notification.content ??
                  NotificationsLabels.notificationDetailsNoContent,
              shrinkWrap: true,
              style: {
                'html': Style(
                  fontFamily:
                      Theme.of(context).textTheme.titleLarge!.fontFamily,
                ),
                'body': Style(
                    // margin: EdgeInsets.zero,
                    ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
