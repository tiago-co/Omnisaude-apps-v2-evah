import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/models/rating_form_model.dart';

class RatingStore extends NotifierStore<Exception, RatingFormModel> {
  RatingStore(RatingFormModel initialState) : super(initialState);

  Future postForm() async {
    setLoading(true);
    final UserStore userStore = Modular.get();
    state.name = userStore.beneficiary.individualPerson?.name;
    state.email = userStore.beneficiary.individualPerson?.user?.email;
    state.phone = userStore.beneficiary.individualPerson?.phone;
    state.module = convertModuleName(state.module!);

    await FirebaseFirestore.instance
        .collection('user-module-reviews')
        .add(state.toMap());

    setLoading(false);
  }

  bool isSelected(int index) {
    if (index == state.ratingValue) {
      return true;
    } else {
      return false;
    }
  }

  void changeValue(int index) {
    state.ratingValue = index;
    update(state);
  }

  void changeDescription(String? input) {
    state.description = input;
    update(state);
  }

  void changeCheckBoxValue(bool? value) {
    state.acceptContact = value ?? false;
    update(state);
  }

  String convertModuleName(String module) {
    String name = '';
    switch (module) {
      case 'assistance':
        name = 'Assistência';
        break;
      case 'pronto_atendimento_virtual':
        name = 'Pronto Atendimento Virtual';
        break;
    }
    return name;
  }
}
