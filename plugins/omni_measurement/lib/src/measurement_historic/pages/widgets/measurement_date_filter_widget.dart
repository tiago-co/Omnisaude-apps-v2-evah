import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/measurement_historic/stores/measurement_date_filter_store.dart';
import 'package:omni_measurement/src/measurement_historic/stores/measurement_historic_store.dart';

class MeasurementDateFilterWidget extends StatefulWidget {
  final DatePickerController dateController;

  const MeasurementDateFilterWidget({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  @override
  _MeasurementDateFilterWidgetState createState() =>
      _MeasurementDateFilterWidgetState();
}

class _MeasurementDateFilterWidgetState
    extends State<MeasurementDateFilterWidget> {
  final MeasurementHistoricDateFilterStore store = Modular.get();
  final Duration duration = const Duration(milliseconds: 500);
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        ScopedBuilder<MeasurementHistoricDateFilterStore, DioError, DateTime>(
          store: store,
          onState: (_, triple) {
            if (!store.isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DateFilterWidget(
                  date: triple,
                  isLoading: store.isLoading,
                  nextMonth: () {
                    store.nextMonth().then(
                      (date) {
                        currentDate = date!;
                        widget.dateController.setDateAndAnimate(
                          date,
                          duration: duration,
                          curve: Curves.decelerate,
                        );
                      },
                    );
                  },
                  previousMonth: () {
                    store.previousMonth().then(
                      (date) {
                        currentDate = date!;
                        widget.dateController.setDateAndAnimate(
                          date,
                          duration: duration,
                          curve: Curves.decelerate,
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const SizedBox(height: 10),
        Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: _buildDatePickerWidget(),
        ),
      ],
    );
  }

  Widget _buildDatePickerWidget() {
    return TripleBuilder<MeasurementHistoricStore, DioError, List<DateTime>>(
      store: store.measurementStore,
      builder: (_, activeDates) {
        return DayPickerTimelineWidget(
          DateTime(store.state.year, store.state.month),
          locale: 'pt_BR',
          controller: widget.dateController,
          activeDates: activeDates.state,
          selectionColor: Theme.of(context).primaryColor,
          initialSelectedDate: store.state,
          deactivatedColor: Theme.of(context).cardColor.withOpacity(0.5),
          monthTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 0,
              ),
          dayTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
          dateTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
          daysCount: DateTime(store.state.year, store.state.month + 1, 0)
                  .difference(
                    DateTime(store.state.year, store.state.month),
                  )
                  .inDays +
              1,
          onDateChange: (date) {
            store.measurementStore.params.date = Formaters.dateToStringDate(
              date,
            );
            store.measurementStore
                .getMeasurements(store.measurementStore.params);
          },
        );
      },
    );
  }
}
