import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';
import 'package:omni_mediktor/src/mediktor_historic/stores/mediktor_historic_date_filter_store.dart';
import 'package:omni_mediktor/src/mediktor_repository.dart';

class MediktorHistoricStore
    extends NotifierStore<DioError, List<MediktorDiagnosisModel>>
    with Disposable {
  final MediktorRepository _repository = Modular.get();
  final MediktorHistoricDateFilterStore mediktorHistoricDateFilterStore =
      Modular.get();

  final List<MediktorDiagnosisModel> completeDiagnosisList =
      List.empty(growable: true);

  MediktorHistoricStore() : super([]);

  Future<void> getDiagnosis() async {
    setLoading(true);
    await _repository.getDiagnosis().then((diagnosisList) {
      completeDiagnosisList.clear();
      completeDiagnosisList.addAll(diagnosisList);

      final List<MediktorDiagnosisModel> filteredList =
          mediktorHistoricDateFilterStore.filterlistByMonth(
        diagnosisList: diagnosisList,
      );
      update(filteredList);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  void nextMonth() {
    setLoading(true);
    mediktorHistoricDateFilterStore.nextMonth();

    final List<MediktorDiagnosisModel> filteredList =
        mediktorHistoricDateFilterStore.filterlistByMonth(
      diagnosisList: completeDiagnosisList,
    );

    update(filteredList);
    setLoading(false);
  }

  void previousMonth() {
    setLoading(true);
    mediktorHistoricDateFilterStore.previousMonth();

    final List<MediktorDiagnosisModel> filteredList =
        mediktorHistoricDateFilterStore.filterlistByMonth(
      diagnosisList: completeDiagnosisList,
    );

    update(filteredList);
    setLoading(false);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
