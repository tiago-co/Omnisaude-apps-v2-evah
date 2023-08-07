
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/vaccine_model.dart';
import 'package:omni_core/src/app/modules/vaccine/vaccine_repository.dart';

class VaccineStore extends NotifierStore<Exception, List<VaccineModel>> {
  VaccineStore() : super([]);
  final VaccineRepository _repository = Modular.get();

  Future<void> getVaccines() async {
    try {
      setLoading(true);
      final List<VaccineModel> vaccineList = await _repository.getVaccines();
      await Future.delayed(const Duration(seconds: 1));
      update(vaccineList);
      setLoading(false);
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }
}
