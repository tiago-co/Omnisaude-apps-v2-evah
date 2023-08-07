import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_step_enum.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/scheduling_progress_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/scheduling_steps_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_professional_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_date_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_hour_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingProfessionalPage extends StatefulWidget {
  final PageController pageController;
  final SchedulingModeType schedulingModeType;
  final String? mediktorId;

  const SchedulingProfessionalPage({
    Key? key,
    required this.pageController,
    required this.schedulingModeType,
    this.mediktorId,
  }) : super(key: key);

  @override
  _SchedulingProfessionalPageState createState() =>
      _SchedulingProfessionalPageState();
}

class _SchedulingProfessionalPageState
    extends State<SchedulingProfessionalPage> {
  final TextEditingController professionalController = TextEditingController();
  final NewSchedulingProfessionalStore professionalStore = Modular.get();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final DateTimePickerService service = DateTimePickerService();
  final SchedulingHourStore hourStore = Modular.get();
  final SchedulingDateStore dateStore = Modular.get();
  final NewSchedulingStore store = Modular.get();

  @override
  void initState() {
    store.params.type = store.state.schedulingType!.toJson;
    if (widget.schedulingModeType == SchedulingModeType.mediktor) {
      store.onMediktorScheduling(widget.mediktorId!).whenComplete(() {
        professionalStore.getProfessionals(store.params);
      });
    } else {
      store.state.mediktor = false;
      professionalStore.getProfessionals(store.params);
    }
    super.initState();
  }

  @override
  void dispose() {
    professionalController.dispose();
    dateController.dispose();
    hourController.dispose();
    dateStore.destroy();
    hourStore.destroy();
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        if (widget.schedulingModeType != SchedulingModeType.mediktor)
          SchedulingProgressWidget(
            modeType: widget.schedulingModeType,
            step: 2,
            progress: 0.67,
            type: SchedulingStepType.schedulingProfessional,
            nextTitle: SchedulingLabels.schedulingProfessionalNextTitle,
          ),
        if (widget.schedulingModeType != SchedulingModeType.mediktor)
          SchedulingStepsWidget(
            pageController: widget.pageController,
            steps: const [
              SchedulingStepType.schedulingCategory,
            ],
          ),
        if (widget.schedulingModeType == SchedulingModeType.mediktor)
          SchedulingProgressWidget(
            modeType: widget.schedulingModeType,
            step: 1,
            progress: 0.50,
            type: SchedulingStepType.schedulingProfessional,
            nextTitle: SchedulingLabels.schedulingProfessionalNextTitle,
          ),
        if (widget.schedulingModeType == SchedulingModeType.mediktor)
          SchedulingStepsWidget(
            pageController: widget.pageController,
            steps: const [],
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProfessionalSelectWidget,
                const SizedBox(height: 15),
                _buildDateWidget,
                const SizedBox(height: 15),
                _buildHourSelectWidget,
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget get _buildProfessionalSelectWidget {
    return TripleBuilder<NewSchedulingProfessionalStore, DioError,
        List<ProfessionalModel>>(
      store: professionalStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: () {
            professionalStore.getProfessionals(store.params);
          },
          child: SelectFieldWidget<ProfessionalModel>(
            label: SchedulingLabels.schedulingProfessionalLabel,
            placeholder: SchedulingLabels.schedulingProfessionalPlaceholder,
            controller: professionalController,
            showSearch: true,
            items: triple.state,
            itemsLabels: triple.state
                .map(
                  (professional) => professional.name!,
                )
                .toList(),
            isLoading: triple.isLoading,
            isEnabled: triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingProfessionalGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? SchedulingLabels.schedulingProfessionalEmpty
                    : null,
            onSelectItem: (professional) {
              professionalController.text = professional.name!;
              store.state.professionalId = professional.id;
              store.state.date = null;
              store.state.hour = null;
              dateController.clear();
              hourController.clear();
              store.updateForm(store.state);
              store.params.date = '${DateTime.now().month}/'
                  '${DateTime.now().year}';
              store.updateForm(store.state);
              dateStore
                  .getProfessionalDays(
                professional.id!,
                store.params,
                DateTime.now(),
              )
                  .then((initialBlackoutDates) {
                dateStore.initialBlackoutDates = initialBlackoutDates!;
              });
            },
          ),
        );
      },
    );
  }

  Widget get _buildDateWidget {
    return TripleBuilder<SchedulingDateStore, DioError,
        List<ProfessionalAvaliableDaysModel>>(
      store: dateStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: store.state.professionalId != null
              ? () {
                  dateStore
                      .getProfessionalDays(
                    store.state.professionalId!,
                    store.params,
                    DateTime.now(),
                  )
                      .then((initialBlackoutDates) {
                    dateStore.initialBlackoutDates = initialBlackoutDates!;
                  });
                }
              : null,
          child: TextFieldWidget(
            label: SchedulingLabels.schedulingProfessionalDateLabel,
            readOnly: true,
            placeholder: SchedulingLabels.schedulingProfessionalDatePlaceholder,
            isEnabled: store.state.professionalId != null &&
                !triple.isLoading &&
                triple.event != TripleEvent.error,
            errorText: triple.event == TripleEvent.error &&
                    store.state.professionalId != null
                ? SchedulingLabels.schedulingProfessionalGeneralError
                : null,
            suffixIcon: triple.isLoading
                ? const CircularProgressIndicator.adaptive()
                : null,
            onTap: () {
              service.selectDate(
                context,
                blackoutDates: dateStore.initialBlackoutDates,
                minDate: DateTime.now(),
                args: (DateTime startDate, DateTime endDate) {
                  return {'date': '${startDate.month}/${startDate.year}'};
                },
                onChangeView: (Map<String, dynamic> args) async {
                  store.params.date = args['date'];
                  final List date = args['date'].split('/');
                  final int month = int.parse(date[0]);
                  final int year = int.parse(date[1]);
                  final DateTime current = DateTime(year, month);
                  return dateStore.getProfessionalDays(
                    store.state.professionalId!,
                    store.params,
                    current,
                  );
                },
              ).then((dateTime) {
                if (dateTime == null) return;
                dateController.text = Formaters.dateToStringDate(dateTime);
                store.params.date = dateController.text;
                store.state.date = dateController.text;
                store.state.hour = null;
                store.updateForm(store.state);
                hourStore.getHoursByProfessional(
                  store.state.professionalId!,
                  store.params,
                );
              });
            },
            controller: dateController,
          ),
        );
      },
    );
  }

  Widget get _buildHourSelectWidget {
    return TripleBuilder<SchedulingHourStore, DioError, List<String>>(
      store: hourStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: store.state.date != null
              ? () {
                  hourStore.getHoursByProfessional(
                    store.state.professionalId!,
                    store.params,
                  );
                }
              : null,
          child: SelectFieldWidget<String>(
            label: SchedulingLabels.schedulingProfessionalHourLabel,
            placeholder: SchedulingLabels.schedulingProfessionalHourPlaceholder,
            controller: hourController,
            showSearch: true,
            items: triple.state,
            itemsLabels: triple.state,
            isLoading: triple.isLoading,
            isEnabled: triple.event != TripleEvent.error &&
                store.state.date != null &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingProfessionalGeneralError
                : triple.state.isEmpty &&
                        !triple.isLoading &&
                        store.state.date != null &&
                        store.state.professionalId != null
                    ? SchedulingLabels.schedulingProfessionalHourEmpty
                    : null,
            onSelectItem: (hour) {
              store.state.hour = hour;
              hourController.text = hour;
              store.updateForm(store.state);
            },
          ),
        );
      },
    );
  }
}
