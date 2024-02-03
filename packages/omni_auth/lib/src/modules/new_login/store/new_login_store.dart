import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/auth_repository.dart';
import 'package:omni_auth/src/modules/login/stores/obscure_text_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/credential_model.dart';
import 'package:omni_general/src/core/models/new_credential_model.dart';

class NewLoginStore extends NotifierStore<DioError, NewCredentialModel> with Disposable {
  NewLoginStore() : super(NewCredentialModel());

  final ObscureTextStore obscureTextStore = Modular.get();
  final UseBiometricsStore useBiometricsStore = Modular.get();
  final AuthRepository _repository = Modular.get();
  final PreferencesService preferencesService = PreferencesService();
  bool hasSavedCredential = false;

  void updateForm(NewCredentialModel form) {
    update(NewCredentialModel.fromJson(form.toJson()));
  }

  Future<void> authenticate(NewCredentialModel data) async {
    setLoading(true);
    await _repository.newAuthenticate(data).then(
      (prefs) async {
        preferencesService.setHasBiometrics(useBiometricsStore.state);

        if (prefs.beneficiary?.individualPerson?.phone != null &&
            prefs.beneficiary!.individualPerson!.phone != '11999995555') {
          Modular.to.navigate('/newHome');
        } else {
          Modular.to.pushNamed(
            '/auth/signUp/signUpPage',
            arguments: {
              'data': prefs,
              'password': data.password,
            },
          );
        }

        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);

        throw onError;
      },
    );
    setLoading(false);
  }

  bool get isDisabled {
    return state.password == null ||
        state.username == null ||
        (state.password != null && state.password!.length < 3) ||
        (state.username != null && state.username!.length < 3);
  }

  Future<NewCredentialModel> getCredential() async {
    final credential = await preferencesService.getCredential();
    if (credential.password != null) hasSavedCredential = true;
    return credential;
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
