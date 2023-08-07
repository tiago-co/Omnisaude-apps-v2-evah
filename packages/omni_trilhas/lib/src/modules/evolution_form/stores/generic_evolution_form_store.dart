import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/generic_evolution_form/generic_evolution_form.dart';
import 'package:omni_trilhas/src/modules/evolution_form/evolution_form_repository.dart';

class GenericEvolutionFormStore
    extends NotifierStore<DioError, GenericEvolutionFormModel> {
  final EvolutionFormRepository _repository = Modular.get();

  GenericEvolutionFormStore() : super(GenericEvolutionFormModel());

  Future<void> getGenericEvolutionById(
      String id, EvolutionFormType type) async {
    setLoading(true);
    await _repository
        .getGenericEvolutionByIdType(id, type)
        .then((genericEvolution) {
      update(genericEvolution);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
