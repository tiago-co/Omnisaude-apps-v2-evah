import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/medicine_historic_store.dart';
import 'package:omni_general/omni_general.dart' show Formaters;

class MedicineHistoricDateFilterStore
    extends NotifierStore<DioError, DateTime> {
  final MedicineHistoricStore medicineStore = Modular.get();

  MedicineHistoricDateFilterStore() : super(DateTime.now());

  Future<DateTime?> nextMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month + 1, state.day);
    medicineStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    medicineStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    update(newDate);
    return medicineStore
        .getDrugControlsDays(medicineStore.params, newDate)
        .then((day) {
      setLoading(false);
      final DateTime date = Formaters.stringToDate(
        medicineStore.params.date!,
        format: 'dd/MM/yyyy',
      );
      return date;
    }).catchError(
      (onError) {
        setLoading(false);
        setError(onError);
      },
    );
  }

  Future<DateTime?> previousMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month - 1, state.day);
    medicineStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    medicineStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    update(newDate);
    return medicineStore
        .getDrugControlsDays(medicineStore.params, newDate)
        .then((day) {
      setLoading(false);
      final DateTime date = Formaters.stringToDate(
        medicineStore.params.date!,
        format: 'dd/MM/yyyy',
      );
      return date;
    }).catchError(
      (onError) {
        setError(onError);
        setLoading(false);
      },
    );
  }
}
