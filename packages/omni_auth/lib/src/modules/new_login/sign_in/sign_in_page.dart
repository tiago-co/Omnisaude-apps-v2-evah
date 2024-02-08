// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/login/stores/login_store.dart';
import 'package:omni_auth/src/modules/new_login/sign_in/widgets/dont_have_account_widget.dart';
import 'package:omni_auth/src/modules/new_login/store/new_login_store.dart';
import 'package:omni_auth/src/modules/new_login/widgets/save_data_dialog.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_login_labels/labels.dart';
import 'package:omni_general/src/core/enums/biometric_type_enum.dart';
import 'package:omni_general/src/core/enums/use_biometric_permission_enum.dart';

class SignInPage extends StatefulWidget {
  SignInPage();

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController username = TextEditingController();

  final TextEditingController password = TextEditingController();

  final FocusNode usernameFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  final NewLoginStore store = Modular.get();

  final UseBiometricsStore useBiometricsStore = Modular.get();

  bool isObscure = true;
  BiometricTypeEnum? biometricType;

  Future<void> askSaveData() async {
    if (!store.hasSavedCredential) {
      await Helpers.showDialog(
        context,
        SaveDataDialog(state: store.state),
      );
    }
  }

  void authenticate() {
    store.authenticate(store.state).catchError(
      (onError) {
        // password.clear();
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
    await LocalAuthService.authenticate().then(
      (value) {
        if (value) authenticate.call();
      },
    );
  }

  void login(BuildContext context) async {
    await store.useBiometricsStore.canAuthenticateUser();
    if (store.useBiometricsStore.canUseBiometricAuth) {
      Helpers.showDialog(
        context,
        Helpers.activateBiometricAuth(
          context,
          () => LocalAuthService.authenticate().then(
            (value) async {
              if (value) {
                authenticate.call();
              } else {}
            },
          ),
          BiometricTypeEnum.fingerprint,
          alternative: () async {
            await askSaveData();
            authenticate();
          },
        ),
      );
    } else {
      await askSaveData();
      authenticate();
    }
  }

  @override
  void initState() {
    super.initState();

    store.getCredential().then((credential) async {
      username.text = credential.cpfOrEmail ?? '';
      store.state.cpfOrEmail = credential.cpfOrEmail ?? '';
      password.text = credential.password ?? '';
      store.state.password = credential.password ?? '';
      final loginBiometric = await useBiometricsStore.getHasBiometrics();
      if (loginBiometric == UseBiometricPermission.accepted && credential.cpfOrEmail != null) {
        await loginWithBiometricMode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.90;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20 * fem, 40 * fem, 20 * fem, 7 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(14.5 * fem, 0 * fem, 33.5 * fem, 28 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // welcomebackdDH (4511:30467)
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      child: Text(
                        'Bem-vindo de volta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2000000817 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                    ),
                    Container(
                      // enteryouraccessdataandwewillta (4511:30468)
                      constraints: BoxConstraints(
                        maxWidth: 306 * fem,
                      ),
                      child: Text(
                        'Insira seus dados de acesso e cuidaremos melhor da sua saúde.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.6000000238 * ffem / fem,
                          color: Color(0xff52576a),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // autogroupznhmbpK (MYmLMNYjpJxFJkyJuSznhm)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 28 * fem),
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      label: 'CPF ou E-mail',
                      controller: username,
                      focusNode: usernameFocus,
                      focusedborder: InputBorder.none,
                      padding: EdgeInsets.zero,
                      textCapitalization: TextCapitalization.none,
                      fem: fem,
                      onChange: (String? input) {
                        store.state.cpfOrEmail = input;
                        store.updateForm(store.state);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFieldWidget(
                      label: 'Senha',
                      controller: password,
                      focusNode: passwordFocus,
                      focusedborder: InputBorder.none,
                      padding: EdgeInsets.zero,
                      textCapitalization: TextCapitalization.none,
                      obscureText: isObscure,
                      fem: fem,
                      maxLines: 1,
                      suffixIcon: InkWell(
                        onTap: () => setState(() {
                          isObscure = !isObscure;
                        }),
                        child: Icon(
                          isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      onChange: (String? input) {
                        store.state.password = input;
                        store.updateForm(store.state);
                      },
                    ),
                    // const SizedBox(height: 12),
                    // WelcomeFormField(
                    //   label: 'Senha',
                    //   controller: password,
                    //   focus: passwordFocus,
                    //   isPassword: true,
                    //   // onChange: (String? input) {
                    //   //   store.state.username = input;
                    //   //   store.updateForm(store.state);
                    //   // },
                    // ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Modular.to.pushNamed('/auth/password');
                      },
                      child: Text(
                        'Esqueceu sua senha?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.6000000238 * ffem / fem,
                          color: const Color(0xff2D73B3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  login(context);
                },
                child: Container(
                  height: 56 * fem,
                  decoration: BoxDecoration(
                    color: true ? Color(0xff2D73B3) : Color(0xff2d72b3),
                    borderRadius: BorderRadius.circular(60 * fem),
                  ),
                  child: SizedBox.expand(
                    child: TripleBuilder(
                      store: store,
                      builder: (context, triple) {
                        if (triple.isLoading) {
                          return const LoadingWidget(
                            indicatorColor: Colors.white,
                          );
                        }
                        return Center(
                          child: Text(
                            'Entrar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.5 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // const DontHaveAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
