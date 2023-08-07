import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/models/consuption_model.dart';
import 'package:omni_drug_control/src/drug_control_historic/drug_control_historic_repository.dart';

class ConsuptionStore extends NotifierStore<DioError, ConsuptionModel> {
  ConsuptionStore()
      : super(
          ConsuptionModel(
            confirmMedicineConsupution: false,
            confirmMedicineNotConsupution: false,
          ),
        );
  final DrugControlHistoricRepository _repository = Modular.get();

  Future<void> informConsumption(
    ConsuptionModel params,
    String id,
  ) async {
    setLoading(true);
    await _repository.informConsumption(params, id).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  void updateForm(ConsuptionModel model) {
    update(ConsuptionModel.fromJson(model.toJson()));
  }
}
