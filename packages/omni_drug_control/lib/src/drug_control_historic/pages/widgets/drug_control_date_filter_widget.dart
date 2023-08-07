import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_date_filter_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/medicine_historic_store.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlDateFilterWidget extends StatefulWidget {
  final DatePickerController dateController;

  const DrugControlDateFilterWidget({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  @override
  _DrugControlDateFilterWidgetState createState() =>
      _DrugControlDateFilterWidgetState();
}

class _DrugControlDateFilterWidgetState
    extends State<DrugControlDateFilterWidget> {
  final MedicineHistoricDateFilterStore store = Modular.get();
  final Duration duration = const Duration(milliseconds: 1000);
  final DateTime now = DateTime.now();
  final GlobalKey key = GlobalKey();

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
        TripleBuilder<MedicineHistoricDateFilterStore, DioError, DateTime>(
          store: store,
          builder: (_, triple) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DateFilterWidget(
                date: triple.state,
                isLoading: triple.isLoading,
                nextMonth: () {
                  store.nextMonth().then(
                    (date) {
                      widget.dateController.setDateAndAnimate(
                        date!,
                        duration: duration,
                        curve: Curves.decelerate,
                      );
                    },
                  );
                },
                previousMonth: () {
                  store.previousMonth().then(
                    (date) {
                      widget.dateController.setDateAndAnimate(
                        date!,
                        duration: duration,
                        curve: Curves.decelerate,
                      );
                    },
                  );
                },
              ),
            );
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
    return ScopedBuilder<MedicineHistoricStore, DioError, List<DateTime>>(
      store: store.medicineStore,
      onState: (_, activeDates) {
        return TripleBuilder<MedicineHistoricDateFilterStore, DioError,
            DateTime>(
          store: store,
          builder: (_, triple) {
            return DayPickerTimelineWidget(
              DateTime(triple.state.year, triple.state.month),
              locale: 'pt_BR',
              activeDates: activeDates,
              controller: widget.dateController,
              selectionColor: Theme.of(context).primaryColor,
              initialSelectedDate: triple.state,
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
              daysCount: DateTime(triple.state.year, triple.state.month + 1, 0)
                      .difference(
                        DateTime(triple.state.year, triple.state.month),
                      )
                      .inDays +
                  1,
              onDateChange: (date) {
                store.medicineStore.params.date = Formaters.dateToStringDate(
                  date,
                );
                store.medicineStore.getMedicines(store.medicineStore.params);
              },
            );
          },
        );
      },
    );
  }
}
