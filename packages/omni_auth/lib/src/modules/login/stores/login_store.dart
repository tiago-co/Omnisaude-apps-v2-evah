import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/auth_repository.dart';
import 'package:omni_auth/src/modules/login/stores/obscure_text_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/credential_model.dart';

class LoginStore extends NotifierStore<DioError, CredentialModel> with Disposable {
  LoginStore() : super(CredentialModel());

  final ObscureTextStore obscureTextStore = Modular.get();
  final UseBiometricsStore useBiometricsStore = Modular.get();
  final AuthRepository _repository = Modular.get();
  final PreferencesService preferencesService = PreferencesService();

  void updateForm(CredentialModel form) {
    update(CredentialModel.fromJson(form.toJson()));
  }

  Future<void> authenticate(CredentialModel data) async {
    setLoading(true);
    // await _repository.authenticate(data).then(
    //   (prefs) async {
    //     preferencesService.setHasBiometrics(useBiometricsStore.state);

    //     setLoading(false);
    //   },
    // ).catchError(
    //   (onError) {
    //     setLoading(false);

    //     throw onError;
    //   },
    // );
    setLoading(false);
  }

  bool get isDisabled {
    return state.password == null ||
        state.username == null ||
        (state.password != null && state.password!.length < 3) ||
        (state.username != null && state.username!.length < 3);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
