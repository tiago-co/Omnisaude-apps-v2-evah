import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';

class SchedulingDateFilterStore extends NotifierStore<DioError, DateTime> {
  final SchedulingHistoricStore historicStore = Modular.get();

  SchedulingDateFilterStore() : super(DateTime.now());

  Future<void> nextMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month + 1);
    historicStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    historicStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    update(newDate);
    await historicStore
        .getSchedules(historicStore.params)
        .catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }

  Future<void> previousMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month - 1);
    historicStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    historicStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    update(newDate);
    await historicStore
        .getSchedules(historicStore.params)
        .catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
    update(newDate);
  }
}
