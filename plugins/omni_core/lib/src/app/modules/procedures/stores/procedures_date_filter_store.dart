import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_store.dart';
import 'package:omni_general/omni_general.dart';

class ProceduresDateFilterStore extends NotifierStore<DioError, DateTime> {
  final ProceduresStore proceduresStore = Modular.get();

  ProceduresDateFilterStore() : super(DateTime.now());

  Future<void> nextMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month + 1, state.day);
    proceduresStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    proceduresStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    update(newDate);
    await proceduresStore
        .getProcedures(proceduresStore.params)
        .catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }

  Future<void> previousMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month - 1, state.day);
    proceduresStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    proceduresStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    update(newDate);
    await proceduresStore
        .getProcedures(proceduresStore.params)
        .catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
    update(newDate);
  }
}
