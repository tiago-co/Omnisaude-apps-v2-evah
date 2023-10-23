import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/drug_control_historic_repository.dart';

import 'package:omni_general/omni_general.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// ignore: must_be_immutable
class DrugControlHistoricStore extends NotifierStore<DioError, DrugControlResultsModel> with Disposable {
  final DrugControlHistoricRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  DrugControlHistoricStore() : super(DrugControlResultsModel(results: []));
  Timer? _debounce;

  Future<void> getDrugControls(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getDrugControls(params).then((drugControls) {
      update(drugControls);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getDrugControlsParams(String? name) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.name = name;
      await getDrugControls(params);
    });
  }

  _AppointmentDataSource getCalendarDataSource() {
    final listAppointsments = state.results?.map<Appointment>((e) {
      // final day = Formaters.stringToDate(e.startDate!);
      final day = DateTime.parse(e.startDate!);
      final today = DateTime(2023, 10, 22, day.hour, day.minute);
      return Appointment(
        startTime: today,
        endTime: today.add(const Duration(minutes: 30)),
        subject: e.medicine ?? '',
        id: e.id,
      );
    }).toList();

    return _AppointmentDataSource(listAppointsments!);
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
