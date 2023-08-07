import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

// ignore: must_be_immutable
class SchedulingDateStore
    extends NotifierStore<DioError, List<ProfessionalAvaliableDaysModel>>
    with Disposable {
  final SchedulingRepository _repository = Modular.get();

  SchedulingDateStore() : super([]);

  late List<DateTime> initialBlackoutDates;

  Future<List<DateTime>?> getProfessionalDays(
    String id,
    SchedulingParamsModel params,
    DateTime current,
  ) async {
    setLoading(true);
    return _repository.getProfessionalDays(id, params).then((dates) {
      update(dates!);
      setLoading(false);
      return getBlackoutDates(dates, current);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  List<DateTime> getBlackoutDates(
    List<ProfessionalAvaliableDaysModel> days,
    DateTime current,
  ) {
    final List<DateTime> blackoutDays = List<DateTime>.empty(growable: true);
    days.forEach((day) {
      if (day.isAvaliable!) return;
      final DateTime dateTime = DateTime(current.year, current.month, day.day!);
      blackoutDays.add(dateTime);
    });
    return blackoutDays;
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
