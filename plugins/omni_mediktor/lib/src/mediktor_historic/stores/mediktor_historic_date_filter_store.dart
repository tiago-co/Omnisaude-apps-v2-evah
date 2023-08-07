import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';

class MediktorHistoricDateFilterStore
    extends NotifierStore<DioError, DateTime> {
  MediktorHistoricDateFilterStore() : super(DateTime.now());

  void nextMonth() {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month + 1, state.day);
    update(newDate);

    setLoading(false);
  }

  void previousMonth() {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month - 1, state.day);

    update(newDate);

    setLoading(false);
  }

  List<MediktorDiagnosisModel> filterlistByMonth({
    required List<MediktorDiagnosisModel> diagnosisList,
  }) {
    setLoading(true);
    final List<MediktorDiagnosisModel> filteredList = List.from(diagnosisList);

    filteredList.removeWhere(
      (diagnosis) {
        final DateTime diagnosisDate = _convertNumToDate(diagnosis.date!);
        if (diagnosisDate.year != state.year ||
            diagnosisDate.month != state.month) {
          return true;
        }

        return false;
      },
    );

    setLoading(false);
    return filteredList;
  }

  DateTime _convertNumToDate(num date) {
    return DateTime.fromMillisecondsSinceEpoch(date.toInt());
  }
}
