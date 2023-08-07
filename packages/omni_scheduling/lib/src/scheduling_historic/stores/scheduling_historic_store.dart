import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

class SchedulingHistoricStore
    extends NotifierStore<DioError, SchedulingResultsModel> with Disposable {
  static DateTime now = DateTime.now();
  final SchedulingRepository _repository = Modular.get();
  final SchedulingParamsModel params = SchedulingParamsModel(
    startDate: Formaters.dateToStringDate(DateTime(now.year, now.month)),
    endDate: Formaters.dateToStringDate(DateTime(now.year, now.month + 1, 0)),
  );

  SchedulingHistoricStore() : super(SchedulingResultsModel(results: []));

  Future<void> getSchedules(SchedulingParamsModel params) async {
    log(params.type ?? 'Tipo de agendamento não definido');
    setLoading(true);
    await _repository.getSchedules(params).then((schedules) {
      update(schedules);
      setLoading(false);
    }).catchError((onError) {
      log(onError);
      setLoading(false);
      setError(onError);
    });
  }

  void updateScheduling(SchedulingModel scheduling) {
    bool wasRescheduled = false;
    final List<SchedulingModel> schedules = state.results.map((obj) {
      if (obj.id == scheduling.id || obj.id == scheduling.oldId) {
        final DateTime date1 = Formaters.stringToDate(obj.startDate!);
        final DateTime date2 = Formaters.stringToDate(scheduling.startDate!);
        if (date1.month != date2.month || date1.year != date2.year) {
          wasRescheduled = true;
        }
        return scheduling;
      }
      return obj;
    }).toList();

    if (wasRescheduled) {
      schedules.removeWhere((obj) => obj.id == scheduling.id);
    }

    update(
      SchedulingResultsModel.fromJson(state.toJson())..results = schedules,
    );
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
