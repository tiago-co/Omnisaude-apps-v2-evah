import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/constants/drug_control_interval.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_administration_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_dosage_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_unity_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlHowUseWidget extends StatefulWidget {
  final bool useCustomMedication;

  const NewDrugControlHowUseWidget({
    Key? key,
    required this.useCustomMedication,
  }) : super(key: key);

  @override
  _NewDrugControlHowUseWidgetState createState() =>
      _NewDrugControlHowUseWidgetState();
}

class _NewDrugControlHowUseWidgetState extends State<NewDrugControlHowUseWidget>
    with SingleTickerProviderStateMixin {
  final DateTimePickerService service = DateTimePickerService();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startHourController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final Duration duration = const Duration(milliseconds: 250);
  final NewDrugControlStore store = Modular.get();
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    startDateController.dispose();
    startHourController.dispose();
    intervalController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SelectFieldWidget<MapEntry>(
            showSearch: true,
            label: DrugControlLabels.newDrugControlIntervalLabel,
            items: DRUG_CONTROL_INTERVALS.entries.toList(),
            itemsLabels: DRUG_CONTROL_INTERVALS.values.toList(),
            placeholder: DrugControlLabels.newDrugControlIntervalPlaceholder,
            controller: intervalController,
            onSelectItem: (interval) {
              intervalController.text = interval.value;
              store.state.interval = interval.key;
              store.update(store.state);
            },
          ),
          const SizedBox(height: 15),
          _buildStartDateTime,
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NewDrugControlDosageWidget(
                  useCustomMedication: widget.useCustomMedication,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: NewDrugControlUnityWidget(
                  useCustomMedication: widget.useCustomMedication,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          NewDrugControlAdministrationWidget(
            useCustomMedication: widget.useCustomMedication,
          ),
          const SizedBox(height: 15),
          _buildContinuousUsageWidget,
          AnimatedBuilder(
            animation: animationController,
            builder: (_, child) => _buildEndDateTime,
          ),
        ],
      ),
    );
  }

  Widget get _buildStartDateTime {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFieldWidget(
          label: DrugControlLabels.newDrugControlStartDateLabel,
          placeholder: DrugControlLabels.newDrugControlStartDatePlaceholder,
          readOnly: true,
          onTap: () async {
            await service
                .selectDate(
              context,
              minDate: DateTime(2021),
              enablePastDates: true,
            )
                .then((dateTime) {
              FocusScope.of(context).requestFocus(FocusNode());
              if (dateTime == null) return;
              startDateController.text = Formaters.dateToStringDate(dateTime);
              store.state.startDate = dateTime.toIso8601String();
              startHourController.clear();
              endDateController.clear();
              store.state.startHour = null;
              store.state.endDate = null;
              store.updateForm(store.state);
            });
          },
          controller: startDateController,
        ),
        const SizedBox(height: 15),
        TripleBuilder<NewDrugControlStore, DioError, DrugControlModel>(
          store: store,
          builder: (_, triple) {
            return TextFieldWidget(
              label: DrugControlLabels.newDrugControlStartHourLabel,
              placeholder: DrugControlLabels.newDrugControlStartHourPlaceholder,
              readOnly: true,
              isEnabled: triple.state.startDate != null,
              onTap: () async {
                late final DateTime dateTime;
                try {
                  dateTime = Formaters.stringToDateTime(store.state.startDate!);
                } on FormatException {
                  dateTime = Formaters.stringToDateTime(store.state.startHour!);
                }
                await service
                    .selectTime(context, initialDateTime: dateTime)
                    .then((dateTime) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (dateTime == null) return;
                  startHourController.text = Formaters.dateToStringTime(
                    dateTime,
                  );
                  store.state.startHour = dateTime.toIso8601String();
                  store.state.startDate = Formaters.dateToStringDateTime(
                    dateTime,
                  );
                  store.updateForm(store.state);
                });
              },
              controller: startHourController,
            );
          },
        ),
      ],
    );
  }

  Widget get _buildContinuousUsageWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ListTile(
            title: Text(
              DrugControlLabels.newDrugControlContinuousUsageTitle,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight:
                        store.continuousUsageSwitch ? FontWeight.w600 : null,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            trailing: CupertinoSwitch(
              value: store.continuousUsageSwitch,
              trackColor: Theme.of(context).cardColor.withOpacity(0.25),
              activeColor: Theme.of(context).primaryColor,
              onChanged: (bool value) {
                if (animationController.isDismissed) {
                  animationController.forward();
                  endDateController.clear();
                  store.state.endDate = null;
                } else {
                  animationController.reverse();
                }
                store.onChangeContinuousUsageValue(
                  !store.continuousUsageSwitch,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget get _buildEndDateTime {
    return TripleBuilder<NewDrugControlStore, DioError, DrugControlModel>(
      store: store,
      builder: (_, triple) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: TextFieldWidget(
              label: DrugControlLabels.newDrugControlEndDateLabel,
              placeholder: DrugControlLabels.newDrugControlEndDatePlaceholder,
              readOnly: true,
              isEnabled: triple.state.startDate != null,
              onTap: () async {
                final DateTime minDate = Formaters.stringToDateTime(
                  store.state.startHour!,
                );
                await service
                    .selectDate(
                  context,
                  minDate: minDate.add(const Duration(days: 1)),
                  enablePastDates: true,
                  initialDisplayDate: minDate,
                )
                    .then((dateTime) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (dateTime == null) return;
                  endDateController.text = Formaters.dateToStringDate(
                    dateTime,
                  );
                  store.state.endDate = Formaters.dateToStringDate(dateTime);
                  store.updateForm(store.state);
                });
              },
              controller: endDateController,
            ),
          ),
        );
      },
    );
  }
}
