import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/models/notification_model.dart';
import 'package:omni_general/omni_general.dart';

class ReminderItemWidget extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> notification;
  final Function(ModuleModel) navigate;

  const ReminderItemWidget({
    Key? key,
    required this.notification,
    required this.navigate,
  }) : super(key: key);

  @override
  _ReminderItemWidgetState createState() => _ReminderItemWidgetState();
}

class _ReminderItemWidgetState extends State<ReminderItemWidget> {
  late NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    notification = NotificationModel.fromJson(widget.notification.data());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -5,
            color: Theme.of(context).cardColor,
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    notification.title ??
                        NotificationsLabels.reminderItemNoTitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  DefaultButtonWidget(
                    onPressed: () {
                      final ModuleModel module = ModuleModel(
                        type: notification.destino!.type ?? ModuleType.general,
                        category: notification.destino!.category ??
                            ModuleCategoryType.other,
                        name: notification.destino!.type?.name(
                              notification.destino!.type!,
                            ) ??
                            NotificationsLabels.reminderItemNoDestiny,
                        active: true,
                      );
                      widget.navigate(module);
                    },
                    buttonType: DefaultButtonType.outline,
                    text: NotificationsLabels.reminderItemSee,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: Theme.of(context).cardColor.withOpacity(0.25),
                child: AbsorbPointer(
                  child: ImageWidget(
                    url: notification.banner ?? '',
                    asset: Assets.notificationOne,
                    assetBase: Assets.notificationTwo,
                    height: 100,
                    width: 100,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
