import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/evolution_form_doctor_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/evolution_form_repository.dart';

class MedicalEvolutionFormStore
    extends NotifierStore<DioError, EvolutionFormDoctorModel> {
  final EvolutionFormRepository _repository = Modular.get();

  MedicalEvolutionFormStore() : super(EvolutionFormDoctorModel());

  Future<void> getMedicalEvolutionById(String id) async {
    setLoading(true);
    await _repository.getMedicalEvolutionById(id).then((medicalEvolution) {
      update(medicalEvolution);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
