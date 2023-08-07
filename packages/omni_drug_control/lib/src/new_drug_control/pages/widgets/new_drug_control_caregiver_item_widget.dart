import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_caregiver_notifications_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';

class NewDrugControlCaregiverItemWidget extends StatefulWidget {
  final CaregiverModel caregiver;
  const NewDrugControlCaregiverItemWidget({
    Key? key,
    required this.caregiver,
  }) : super(key: key);

  @override
  _NewDrugControlCaregiverItemWidgetState createState() =>
      _NewDrugControlCaregiverItemWidgetState();
}

class _NewDrugControlCaregiverItemWidgetState
    extends State<NewDrugControlCaregiverItemWidget>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 100);
  late final AnimationController animationController;
  late final Animation<double> animation;

  final NewDrugControlCaregiverNotificationsStore notificationsStore =
      Modular.get();
  final NewDrugControlStore newDrugControlStore =
      Modular.get<NewDrugControlStore>();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      animationController,
    );
    notificationsStore.state.sendEmail = widget.caregiver.sendEmail;
    notificationsStore.state.sendSMS = widget.caregiver.sendSMS;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: animationController.isDismissed
                ? null
                : BorderRadius.circular(10),
            border: animationController.isDismissed
                ? Border(
                    bottom: BorderSide(
                      color: Theme.of(context).cardColor,
                      width: 0.1,
                    ),
                  )
                : Border.all(
                    color: Theme.of(context).cardColor,
                    width: 0.1,
                  ),
            boxShadow: animationController.isDismissed
                ? null
                : [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: -5,
                      color: Theme.of(context).cardColor,
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CheckboxListTile(
                value: animationController.isCompleted,
                dense: false,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  widget.caregiver.name!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool? value) {
                  if (value == null) return;
                  if (value) {
                    newDrugControlStore.state.caregivers.add(widget.caregiver);
                    newDrugControlStore.updateForm(newDrugControlStore.state);
                    animationController.forward();
                  } else {
                    newDrugControlStore.state.caregivers.removeWhere(
                      (caregiver) => caregiver.id == widget.caregiver.id,
                    );
                    newDrugControlStore.updateForm(newDrugControlStore.state);
                    animationController.reverse();
                  }
                },
              ),
              FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: Column(
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: TripleBuilder<
                            NewDrugControlCaregiverNotificationsStore,
                            DioError,
                            CaregiverNotificationsModel>(
                          store: notificationsStore,
                          builder: (_, triple) {
                            return IgnorePointer(
                              ignoring: triple.isLoading,
                              child: Opacity(
                                opacity: triple.isLoading ? 0.5 : 1.0,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const Divider(),
                                    SwitchListTile(
                                      value: triple.state.sendSMS!,
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      activeTrackColor:
                                          Theme.of(context).primaryColor,
                                      title: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          DrugControlLabels
                                              .newDrugControlCaregiverSMS,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        triple.state.sendSMS = value;
                                        notificationsStore.onChangeSMSCheck(
                                          value,
                                          widget.caregiver.id!,
                                        );
                                      },
                                    ),
                                    const Divider(),
                                    SwitchListTile(
                                      value: triple.state.sendEmail!,
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      activeTrackColor:
                                          Theme.of(context).primaryColor,
                                      title: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          DrugControlLabels
                                              .newDrugControlCaregiverEmail,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        triple.state.sendEmail = value;
                                        notificationsStore.onChangeEmailCheck(
                                          value,
                                          widget.caregiver.id!,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
