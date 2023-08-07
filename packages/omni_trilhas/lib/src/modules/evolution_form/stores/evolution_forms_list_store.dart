import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/evolution_form_repository.dart';

// ignore: must_be_immutable
class EvolutionFormsListStore
    extends NotifierStore<DioError, List<EvolutionFormModel>> {
  EvolutionFormsListStore(this.evolutionFormType) : super([]);

  final EvolutionFormRepository _repository = Modular.get();
  final EvolutionFormType evolutionFormType;

  Future<void> getSpecificEvolutionForm() async {
    setLoading(true);
    await _repository
        .getEvolutionsList(evolutionFormType)
        .then((medicalEvolutions) {
      update(medicalEvolutions);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
