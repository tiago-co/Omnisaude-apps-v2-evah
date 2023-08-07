import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/reminder_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/reminder_item_widget.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notifications_store.dart';
import 'package:omni_core/src/app/modules/notifications/stores/reminders_store.dart';
import 'package:omni_general/omni_general.dart';

class ReminderListWidget extends StatefulWidget {
  final ScrollController reminderController;

  const ReminderListWidget({
    Key? key,
    required this.reminderController,
  }) : super(key: key);

  @override
  _ReminderListWidgetState createState() => _ReminderListWidgetState();
}

class _ReminderListWidgetState extends State<ReminderListWidget> {
  final NotificationsStore store = Modular.get();
  final ModulesStore modulesStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(
            NotificationsLabels.reminderListTitle,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        TripleBuilder<ReminderStore, Exception,
            List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          store: store.reminderStore,
          builder: (_, triple) {
            if (triple.isLoading && triple.state.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(height: 2.5),
                  ),
                  ReminderItemShimmerWidget(),
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
                      message: NotificationsLabels.reminderListEmpty,
                      isLoading: triple.isLoading,
                    ),
                  ),
                if (triple.state.isNotEmpty)
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    controller: widget.reminderController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        triple.state.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 15),
                          child: AbsorbPointer(
                            absorbing: triple.isLoading,
                            child: Opacity(
                              opacity: triple.isLoading ? 0.5 : 1.0,
                              child: ReminderItemWidget(
                                notification: triple.state[index],
                                navigate: (ModuleModel module) {
                                  modulesStore.navigate(module);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
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
