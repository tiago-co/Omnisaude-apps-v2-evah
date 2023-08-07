import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_step_enum.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/scheduling_progress_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/toggle_type_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingTypePage extends StatefulWidget {
  final SchedulingModeType schedulingModeType;
  final Function(NewSchedulingModel, SchedulingType) nextOrCreateScheduling;
  const SchedulingTypePage({
    Key? key,
    required this.schedulingModeType,
    required this.nextOrCreateScheduling,
  }) : super(key: key);

  @override
  _SchedulingTypePageState createState() => _SchedulingTypePageState();
}

class _SchedulingTypePageState extends State<SchedulingTypePage> {
  final NewSchedulingStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        if (widget.schedulingModeType == SchedulingModeType.mediktor)
          SchedulingProgressWidget(
            modeType: widget.schedulingModeType,
            step: 1,
            progress: 0.33,
            type: SchedulingStepType.schedulingProfessional,
            nextTitle: SchedulingLabels.schedulingTypeNextTitleWithMediktor,
          ),
        if (widget.schedulingModeType != SchedulingModeType.mediktor)
          SchedulingProgressWidget(
            modeType: widget.schedulingModeType,
            step: 1,
            progress: 0.25,
            type: SchedulingStepType.schedulingCategory,
            nextTitle: SchedulingLabels.schedulingTypeNextTitleWithoutMediktor,
          ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    SchedulingLabels.schedulingTypeDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  TripleBuilder<NewSchedulingStore, Exception,
                      NewSchedulingModel>(
                    store: store,
                    builder: (_, triple) {
                      return Row(
                        children: [
                          Expanded(
                            child: ToggleTypeWidget(
                              isActive: triple.state.schedulingType ==
                                  SchedulingType.presential,
                              type: SchedulingType.presential,
                              model: store.state,
                              onTap: widget.nextOrCreateScheduling,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ToggleTypeWidget(
                              isActive: triple.state.schedulingType ==
                                  SchedulingType.teleAttendance,
                              type: SchedulingType.teleAttendance,
                              model: store.state,
                              onTap: widget.nextOrCreateScheduling,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
