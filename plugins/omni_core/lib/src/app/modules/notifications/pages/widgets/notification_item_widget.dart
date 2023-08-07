import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/src/app/core/models/notification_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notifications_store.dart';
import 'package:omni_general/omni_general.dart';

class NotificationItemWidget extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> notification;

  const NotificationItemWidget({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  _NotificationItemWidgetState createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  final NotificationsStore store = Modular.get();
  late NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    notification = NotificationModel.fromJson(widget.notification.data());
    return GestureDetector(
      onTap: () {
        store.markAsReadNotification(widget.notification.reference);
        Modular.to.pushNamed(
          'notificationDetails',
          arguments: widget.notification,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: -5,
              color: Theme.of(context).cardColor,
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withOpacity(0.25),
              ),
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.seen
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(7.5),
                child: Stack(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        Assets.notificationOne,
                        width: 20,
                        height: 20,
                        package: AssetsPackage.omniGeneral,
                        color: notification.seen
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        Assets.notificationTwo,
                        width: 20,
                        height: 20,
                        package: AssetsPackage.omniGeneral,
                        color: notification.seen
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoWidget(
                        Icons.date_range_outlined,
                        notification.createdAt == null
                            ? NotificationsLabels.notificationItemCreatedAtDate
                            : Formaters.dateToStringDate(
                                DateTime.fromMillisecondsSinceEpoch(
                                  notification
                                      .createdAt!.millisecondsSinceEpoch,
                                ),
                              ),
                      ),
                      _buildInfoWidget(
                        Icons.schedule_rounded,
                        notification.createdAt == null
                            ? NotificationsLabels
                                .notificationItemNoCreatedAtTime
                            : Formaters.dateToStringTime(
                                DateTime.fromMillisecondsSinceEpoch(
                                  notification
                                      .createdAt!.millisecondsSinceEpoch,
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    notification.title ??
                        NotificationsLabels.notificationItemNoTitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              package: AssetsPackage.omniGeneral,
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoWidget(IconData iconData, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Theme.of(context).primaryColor,
          size: 16,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 11,
              ),
        ),
      ],
    );
  }
}
