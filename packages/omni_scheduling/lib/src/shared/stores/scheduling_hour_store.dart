import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

class SchedulingHourStore extends NotifierStore<DioError, List<String>>
    with Disposable {
  final SchedulingRepository _repository = Modular.get();

  SchedulingHourStore() : super([]);

  Future<void> getHoursByProfessional(
    String id,
    SchedulingParamsModel params,
  ) async {
    setLoading(true);
    await _repository.getHoursByProfessional(id, params).then((hours) {
      update(hours!);
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
