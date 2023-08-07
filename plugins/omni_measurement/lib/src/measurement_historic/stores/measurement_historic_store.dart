import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/core/repositories/measurement_historic_repository.dart';

// ignore: must_be_immutable
class MeasurementHistoricStore extends NotifierStore<DioError, List<DateTime>>
    with Disposable {
  MeasurementResultsModel measurements = MeasurementResultsModel(results: []);
  final MeasumentHistoricRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  MeasurementHistoricStore() : super([]);

  Future<int?> getMeasurementDays(QueryParamsModel params, DateTime now) async {
    setLoading(true);
    // measurements.results = [];
    return _repository.getMeasurementsDays(params).then((days) async {
      state.clear();
      final List<DateTime> availableDays = List.empty(growable: true);
      bool hasDayAvailable = false;
      int? day;
      if (days.isNotEmpty) {
        days.forEach((int? element) {
          if (element != null) {
            availableDays.add(DateTime(now.year, now.month, element));
            if (now.month == DateTime.now().month) {
              day = DateTime.now().day;
              hasDayAvailable = true;
            }
            if (!hasDayAvailable && day == null) {
              day = element;
              hasDayAvailable = true;
            }
          }
        });
      } else {
        if (now.month == DateTime.now().month) {
          day = DateTime.now().day;
          hasDayAvailable = true;
        }
      }
      params.date = Formaters.dateToStringDate(
        DateTime(now.year, now.month, day ?? now.day),
      );
      await _repository.getMeasurements(params).then((measurements) {
        this.measurements = measurements;
      });
      if (availableDays.isNotEmpty) {
        state.addAll(availableDays);
      }
      update(state, force: true);

      setLoading(false);

      return day;
    }).catchError((onError) {
      measurements.results = [];
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getMeasurements(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getMeasurements(params).then((measurements) {
      this.measurements = measurements;
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
