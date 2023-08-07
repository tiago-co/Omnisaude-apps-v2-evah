import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notification_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notification_item_widget.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notifications_store.dart';
import 'package:omni_general/omni_general.dart';

class NotificationListWidget extends StatefulWidget {
  final ScrollController notificationController;

  const NotificationListWidget({
    Key? key,
    required this.notificationController,
  }) : super(key: key);

  @override
  _NotificationListWidgetState createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  final NotificationsStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(
            NotificationsLabels.notificationsListAll,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        TripleBuilder<NotificationsStore, Exception,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading && triple.state.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(height: 2.5),
                  ),
                  NotificationItemShimmerWidget(),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!triple.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(height: 2.5),
                  ),
                if (triple.isLoading && triple.state.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: LinearProgressIndicator(
                      minHeight: 2.5,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                if (triple.state.isEmpty || triple.event == TripleEvent.error)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: EmptyWidget(
                      message: NotificationsLabels.notificationsListEmpty,
                      isLoading: triple.isLoading,
                    ),
                  ),
                if (triple.state.isNotEmpty)
                  SafeArea(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: triple.state.length,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 15,
                      ),
                      itemBuilder: (_, index) {
                        return AbsorbPointer(
                          absorbing: triple.isLoading,
                          child: Opacity(
                            opacity: triple.isLoading ? 0.5 : 1.0,
                            child: NotificationItemWidget(
                              notification: triple.state[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
