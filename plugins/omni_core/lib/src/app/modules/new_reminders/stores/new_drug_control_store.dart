import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/new_drug_control_repository.dart';

// ignore: must_be_immutable
class NewDrugControlStore extends NotifierStore<DioError, DrugControlModel> with Disposable {
  final NewDrugControlRepository _repository = Modular.get();

  NewDrugControlStore() : super(DrugControlModel(caregivers: []));

  int pageSelected = 0;
  bool continuousUsageSwitch = false;

  void onChangeContinuousUsageValue(bool value) {
    setLoading(true);
    continuousUsageSwitch = value;
    state.continuousUse = value;
    setLoading(false);
  }

  void updateForm(DrugControlModel form) {
    update(DrugControlModel.fromJson(form.toJson()));
  }

  Future<void> createDrugControl(DrugControlModel data) async {
    setLoading(true);
    await _repository.createDrugControl(data).then((drugControl) {
      update(drugControl);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  bool isDisable() {
    return false;
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
