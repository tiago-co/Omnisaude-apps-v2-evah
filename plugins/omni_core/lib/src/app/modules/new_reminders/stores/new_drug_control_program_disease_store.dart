import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/enums/drug_control_enum.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';

class NewDrugControlProgramDiseaseStore extends NotifierStore<Exception, bool> {
  final NewDrugControlStore drugControlStore = Modular.get();

  NewDrugControlProgramDiseaseStore() : super(false);

  void onChangeCheckBoxValue(bool active) {
    if (active) {
      drugControlStore.state.type = DrugControlType.primaryRegistered;
    } else {
      drugControlStore.state.type = DrugControlType.secondary;
    }
    update(active);
  }
}
