import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/login/stores/login_store.dart';
import 'package:omni_auth/src/modules/login/widgets/login_form_widget.dart';
import 'package:omni_auth/src/modules/login/widgets/login_header_widget.dart';
import 'package:omni_auth/src/modules/login/widgets/reset_password_widget.dart';
import 'package:omni_auth/src/shared/widgets/auth_nav_bar_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/credential_model.dart';
import 'package:omni_login_labels/labels.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

  final PreferencesService preferencesService = PreferencesService();

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final UseBiometricsStore useBiometricsStore = Modular.get();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    LocalAuthService.canAuthenticateUser();

    useBiometricsStore.getHasBiometrics();
    super.initState();
  }

  void login() {
    store.authenticate(store.state).then(
      (value) {
        Modular.to.pushReplacementNamed('/home/presentation');
      },
    ).catchError(
      (onError) {
        password.clear();
        store.state.password = null;
        store.updateForm(store.state);
        Helpers.showDialog(
          context,
          RequestErrorWidget(
            error: onError,
            buttonText: LoginLabels.close,
            onPressed: () => Modular.to.pop(),
          ),
          showClose: true,
        );
      },
    );
  }

  Future<void> loginWithBiometricMode() async {
    // final credential = await preferencesService.getCredential();
    // store.authenticate(credential).then(
    //   (value) {
    //     Modular.to.pushReplacementNamed('/home/presentation');
    //   },
    // ).catchError(
    //   (onError) {
    //     password.clear();
    //     Helpers.showDialog(
    //       context,
    //       RequestErrorWidget(
    //         error: onError,
    //         buttonText: LoginLabels.close,
    //         onPressed: () => Modular.to.pop(),
    //       ),
    //       showClose: true,
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthNavBarWidget().build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: TripleBuilder<LoginStore, DioError, CredentialModel>(
          store: store,
          builder: (_, triple) {
            return Opacity(
              opacity: triple.isLoading ? 0.5 : 1.0,
              child: AbsorbPointer(
                absorbing: triple.isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _buildFormBodyWidget),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        child: ResetPasswordWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: TripleBuilder<LoginStore, DioError, CredentialModel>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            onPressed: () {
              if (store.useBiometricsStore.canUseBiometricAuth &&
                  store.useBiometricsStore.state == UseBiometricPermission.notAccepted) {
                Helpers.showDialog(
                  context,
                  Helpers.activateBiometricAuth(
                    context,
                    () => LocalAuthService.authenticate().then(
                      (value) => login.call(),
                    ),
                    store.useBiometricsStore.biometricType!,
                  ),
                );
              } else {
                login();
              }
            },
            // isDisabled: store.isDisabled,
            isLoading: triple.isLoading,
            buttonType: BottomButtonType.outline,
            text: LoginLabels.enter,
          );
        },
      ),
    );
  }

  Widget get _buildFormBodyWidget {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.15,
                top: 20,
              ),
              child: Column(
                children: [
                  const LoginHeaderWidget(),
                  const SizedBox(height: 25),
                  LoginFormWidget(
                    username: username,
                    password: password,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
