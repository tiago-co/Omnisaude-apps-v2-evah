import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/models/medicine_model.dart';
import 'package:omni_drug_control/src/drug_control_historic/drug_control_historic_repository.dart';
import 'package:omni_general/omni_general.dart';

// ignore: must_be_immutable
class MedicineHistoricStore extends NotifierStore<DioError, List<DateTime>>
    with Disposable {
  MedicineResultsModel medicines = MedicineResultsModel(results: []);
  final DrugControlHistoricRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  MedicineHistoricStore() : super([]);

  Future<int?> getDrugControlsDays(
    QueryParamsModel params,
    DateTime now,
  ) async {
    setLoading(true);
    params.date = null;
    return _repository.getDrugControlsDays(params).then((days) async {
      state.clear();
      final List<DateTime> avaliableDays = List.empty(growable: true);
      bool hasDayAvailable = false;
      int? day;
      days.forEach(
        (key, value) {
          if (value) {
            avaliableDays.add(DateTime(now.year, now.month, int.parse(key)));
            if (int.parse(key) == now.day) {
              day = int.parse(key);
              hasDayAvailable = true;
            }
            if (!hasDayAvailable && day == null) {
              day = int.parse(key);
              hasDayAvailable = true;
            }
          }
        },
      );
      params.date = Formaters.dateToStringDate(
        DateTime(now.year, now.month, day ?? 1),
      );
      await _repository.getMedicines(params).then((medicines) {
        this.medicines = medicines;
      });
      state.addAll(avaliableDays);
      update(state);
      setLoading(false);
      return day ?? 1;
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getMedicines(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getMedicines(params).then((medicines) {
      this.medicines = medicines;
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
