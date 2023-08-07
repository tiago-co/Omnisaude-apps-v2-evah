import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/nurse_evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/evolution_form_repository.dart';

class NurseEvolutionFormStore
    extends NotifierStore<DioError, NurseEvolutionFormModel> {
  final EvolutionFormRepository _repository = Modular.get();

  NurseEvolutionFormStore() : super(NurseEvolutionFormModel());

  Future<void> getNurseEvolutionById(String id) async {
    setLoading(true);
    await _repository.getNurseEvolutionById(id).then((nurseEvoltuion) {
      update(nurseEvoltuion);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
