import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_step_enum.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/scheduling_progress_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/scheduling_steps_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_reason_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingObservationPage extends StatefulWidget {
  final PageController pageController;
  final SchedulingModeType schedulingModeType;

  const SchedulingObservationPage({
    Key? key,
    required this.pageController,
    required this.schedulingModeType,
  }) : super(key: key);

  @override
  _SchedulingObservationPageState createState() =>
      _SchedulingObservationPageState();
}

class _SchedulingObservationPageState extends State<SchedulingObservationPage> {
  final TextEditingController reasonController =
      TextEditingController(text: '');
  final NewSchedulingReasonStore reasonStore = Modular.get();
  final NewSchedulingStore store = Modular.get();

  @override
  void initState() {
    reasonStore.getSchedulingReasons();
    super.initState();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          if (widget.schedulingModeType != SchedulingModeType.mediktor)
            SchedulingProgressWidget(
              modeType: widget.schedulingModeType,
              step: 3,
              progress: 1.0,
              type: SchedulingStepType.schedulingObservation,
              nextTitle: SchedulingLabels.schedulingObservationNextTitle,
            ),
          if (widget.schedulingModeType != SchedulingModeType.mediktor)
            SchedulingStepsWidget(
              pageController: widget.pageController,
              steps: const [
                SchedulingStepType.schedulingCategory,
                SchedulingStepType.schedulingProfessional,
              ],
            ),
          if (widget.schedulingModeType == SchedulingModeType.mediktor)
            SchedulingProgressWidget(
              modeType: widget.schedulingModeType,
              step: 2,
              progress: 1.0,
              type: SchedulingStepType.schedulingObservation,
              nextTitle: SchedulingLabels.schedulingObservationNextTitle,
            ),
          if (widget.schedulingModeType == SchedulingModeType.mediktor)
            SchedulingStepsWidget(
              pageController: widget.pageController,
              steps: const [
                SchedulingStepType.schedulingProfessional,
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  SchedulingLabels.schedulingObservationDescription,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                TripleBuilder<NewSchedulingReasonStore, DioError,
                    List<KeyValueModel>>(
                  store: reasonStore,
                  builder: (_, triple) {
                    if (!triple.isLoading && reasonStore.selectActive) {
                      return _buildReasonSelectWidget;
                    }
                    return TextFieldWidget(
                      label:
                          SchedulingLabels.schedulingObservationScheduleReason,
                      placeholder: SchedulingLabels
                          .schedulingObservationScheduleReasonPlaceholder,
                      maxLines: 10,
                      isEnabled: !triple.isLoading,
                      suffixIcon: triple.isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : null,
                      onChange: (String? input) {
                        store.state.reason = input;
                        if (input != null && input.isEmpty) {
                          store.state.reason = null;
                        }
                        store.updateForm(store.state);
                      },
                      controller: reasonController,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get _buildReasonSelectWidget {
    return TripleBuilder<NewSchedulingReasonStore, DioError,
        List<KeyValueModel>>(
      store: reasonStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: () {
            reasonStore.getSchedulingReasons();
          },
          child: SelectFieldWidget<KeyValueModel>(
            label: SchedulingLabels.schedulingObservationScheduleReason,
            placeholder:
                SchedulingLabels.schedulingObservationScheduleReasonPlaceholder,
            controller: reasonController,
            showSearch: true,
            items: triple.state,
            itemsLabels: triple.state.map((reason) => reason.value!).toList(),
            isLoading: triple.isLoading,
            isEnabled: triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingObservationGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? SchedulingLabels.schedulingObservationReasonEmpty
                    : null,
            onSelectItem: (reason) {
              reasonController.text = reason.value!;
              store.state.reason = reason.value;
              store.updateForm(store.state);
            },
          ),
        );
      },
    );
  }
}
