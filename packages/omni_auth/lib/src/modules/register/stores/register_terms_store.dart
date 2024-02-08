import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';

class RegisterTermsStore extends NotifierStore<Exception, bool> {
  final RegisterStore registerStore = Modular.get();

  RegisterTermsStore() : super(false);

  void onChangeCheckBoxValue(bool? value) {
    update(value ?? false);
    // registerStore.state.termsAccepted = state;
    registerStore.updateForm(registerStore.state);
  }
}
