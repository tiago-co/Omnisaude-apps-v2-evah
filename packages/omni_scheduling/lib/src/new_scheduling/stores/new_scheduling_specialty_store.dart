import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/models/specialty_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

class NewSchedulingSpecialtyStore
    extends NotifierStore<DioError, List<SpecialtyModel>> with Disposable {
  final SchedulingRepository _repository = Modular.get();
  NewSchedulingSpecialtyStore() : super([]);

  Future<void> getSpecialties(SchedulingParamsModel params) async {
    setLoading(true);
    await _repository.getSpecialties(params).then((specialties) {
      update(specialties!);
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
