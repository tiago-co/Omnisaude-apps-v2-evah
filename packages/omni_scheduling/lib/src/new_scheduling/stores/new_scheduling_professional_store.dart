
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

class NewSchedulingProfessionalStore
    extends NotifierStore<DioError, List<ProfessionalModel>> with Disposable {
  final SchedulingRepository _repository = Modular.get();

  NewSchedulingProfessionalStore() : super([]);

  Future<void> getProfessionals(SchedulingParamsModel params) async {
    setLoading(true);
    await _repository.getProfessionals(params).then((professionals) {
      update(professionals!);
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
