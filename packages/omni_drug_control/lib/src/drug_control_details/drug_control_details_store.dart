import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control/src/drug_control_details/drug_control_details_repository.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_historic_store.dart';

class DrugControlDetailsStore extends NotifierStore<DioError, DrugControlModel>
    with Disposable {
  final DrugControlDetailsRepository _repository = Modular.get();
  final DrugControlHistoricStore drugControlStore = Modular.get();

  DrugControlDetailsStore() : super(DrugControlModel());

  Future<void> getDrugControlById(String id) async {
    setLoading(true);
    await _repository.getDrugControlById(id).then((drugControl) {
      update(drugControl);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> removeDrugControlById(String id) async {
    setLoading(true);
    await _repository.removeDrugControlById(id).then((drugControl) async {
      drugControlStore.params.limit = '10';
      drugControlStore.getDrugControls(drugControlStore.params);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
