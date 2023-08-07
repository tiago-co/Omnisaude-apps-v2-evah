import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart'
    show
        BottomButtonWidget,
        BottomSheetHeaderWidget,
        DateTimePickerService,
        Formaters,
        RequestErrorWidget,
        SelectFieldWidget,
        SuccessWidget,
        TextFieldWidget;
import 'package:omni_general/omni_general.dart' show Helpers;
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_change_date_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_date_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_hour_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsChangeDateWidget extends StatefulWidget {
  final SchedulingModel scheduling;

  const SchedulingDetailsChangeDateWidget({
    Key? key,
    required this.scheduling,
  }) : super(key: key);

  @override
  _SchedulingDetailsChangeDateWidgetState createState() =>
      _SchedulingDetailsChangeDateWidgetState();
}

class _SchedulingDetailsChangeDateWidgetState
    extends State<SchedulingDetailsChangeDateWidget> {
  final SchedulingDetailsChangeDateStore store = Modular.get();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final DateTimePickerService service = DateTimePickerService();
  final SchedulingHourStore hourStore = Modular.get();
  final SchedulingDateStore dateStore = Modular.get();

  @override
  void initState() {
    final DateTime now = DateTime.now();
    store.params.specialty = widget.scheduling.specialty?.name;
    store.params.date = '${now.month}/${now.year}';
    store.params.type = widget.scheduling.type!.toJson;
    dateStore
        .getProfessionalDays(
      widget.scheduling.professional!.id!,
      store.params,
      now,
    )
        .then((initialBlackoutDates) {
      dateStore.initialBlackoutDates = initialBlackoutDates!;
    });
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    dateController.dispose();
    hourController.dispose();
    dateStore.destroy();
    hourStore.destroy();
    super.dispose();
  }

  void selectDate() {
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
          widget.scheduling.professional!.id!,
          store.params,
          current,
        );
      },
    ).then((dateTime) {
      if (dateTime == null) return;
      dateController.text = Formaters.dateToStringDate(dateTime);
      store.params.date = dateController.text;
      hourController.clear();
      store.update('');
      hourStore.getHoursByProfessional(
        widget.scheduling.professional!.id!,
        store.params,
      );
    });
  }

  void rescheduling() {
    final Map<String, String> data = {
      'acao': 'reagendar',
      'data_inicio': store.state,
    };
    store.updateSchedulingById(widget.scheduling.id!, data).then((value) async {
      Modular.to.pop();
      await Helpers.showDialog(
        context,
        SuccessWidget(
          message: SchedulingLabels.schedulingDetailsChangeDateSuccess,
          onPressed: () {
            Modular.to.pop();
          },
        ),
      );
    }).catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          error: onError,
          buttonText: SchedulingLabels.close,
          onPressed: () => Modular.to.pop(),
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom >= 60
                    ? MediaQuery.of(context).viewInsets.bottom - 60
                    : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetHeaderWidget(
                    title: SchedulingLabels
                        .schedulingDetailsChangeDateRescheduleAppointment,
                  ),
                  TripleBuilder(
                    store: store,
                    builder: (_, triple) {
                      return AbsorbPointer(
                        absorbing: triple.isLoading,
                        child: Opacity(
                          opacity: triple.isLoading ? 0.5 : 1.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildDateWidget,
                              const SizedBox(height: 15),
                              _buildHourSelectWidget,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          TripleBuilder(
            store: store,
            builder: (_, triple) {
              return BottomButtonWidget(
                onPressed: rescheduling,
                isDisabled: store.isDisabled,
                isLoading: triple.isLoading,
                text: SchedulingLabels.schedulingDetailsChangeDateConfirm,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _buildDateWidget {
    return TripleBuilder<SchedulingDateStore, DioError,
        List<ProfessionalAvaliableDaysModel>>(
      store: dateStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: widget.scheduling.professional?.id != null
              ? () {
                  dateStore
                      .getProfessionalDays(
                    widget.scheduling.professional!.id!,
                    store.params,
                    DateTime.now(),
                  )
                      .then((initialBlackoutDates) {
                    dateStore.initialBlackoutDates = initialBlackoutDates!;
                  });
                }
              : null,
          child: TextFieldWidget(
            label: SchedulingLabels.schedulingDetailsChangeDateLabel,
            readOnly: true,
            placeholder:
                SchedulingLabels.schedulingDetailsChangeDatePlaceholder,
            isEnabled: !triple.isLoading && triple.event != TripleEvent.error,
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingDetailsChangeDateGeneralError
                : null,
            suffixIcon: triple.isLoading
                ? const CircularProgressIndicator.adaptive()
                : null,
            onTap: selectDate,
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
          onTap: dateController.text.isNotEmpty
              ? () {
                  hourStore.getHoursByProfessional(
                    widget.scheduling.professional!.id!,
                    store.params,
                  );
                }
              : null,
          child: SelectFieldWidget<String>(
            label: SchedulingLabels.schedulingDetailsChangeDateHourLabel,
            placeholder:
                SchedulingLabels.schedulingDetailsChangeDateHourPlaceholder,
            controller: hourController,
            showSearch: true,
            items: triple.state,
            itemsLabels: triple.state,
            isLoading: triple.isLoading,
            isEnabled: triple.event != TripleEvent.error &&
                dateController.text.isNotEmpty &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingDetailsChangeDateGeneralError
                : triple.state.isEmpty &&
                        !triple.isLoading &&
                        dateController.text.isNotEmpty
                    ? SchedulingLabels.schedulingDetailsChangeDateHourError
                    : null,
            onSelectItem: (hour) {
              hourController.text = hour;
              store.update('${dateController.text} $hour');
            },
          ),
        );
      },
    );
  }
}
