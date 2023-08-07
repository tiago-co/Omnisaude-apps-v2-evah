import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_list_caregiver_store.dart';

class NewDrugControlCaregiverStore extends NotifierStore<Exception, bool> {
  final NewDrugControlListCaregiverStore newDrugControlListCaregiverStore =
      Modular.get<NewDrugControlListCaregiverStore>();
  NewDrugControlCaregiverStore() : super(false);

  Future<void> updateState() async {
    update(!state);
    if (state == true) {
      await newDrugControlListCaregiverStore
          .getCaregivers(newDrugControlListCaregiverStore.params)
          .catchError((onError) {
        throw onError;
      });
    }
  }
}
