// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/new_login/store/new_login_store.dart';
import 'package:omni_auth/src/modules/new_login/widgets/save_data_dialog.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/enums/biometric_type_enum.dart';
import 'package:omni_login_labels/labels.dart';

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
                    SizedBox(
                      height: 150 * fem,
                      child: SvgPicture.asset(Assets.logoSplash),
                    ),
                    const SizedBox(height: 24),
                    Container(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2D73B3),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60 * fem),
                  ),
                ),
                onPressed: () {
                  login(context);
                },
                child: TripleBuilder(
                  store: store,
                  builder: (context, triple) {
                    if (triple.isLoading) {
                      return const LoadingWidget(
                        indicatorColor: Colors.white,
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
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
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  Modular.to.pushNamed('/auth/firstAcess');
                },
                child: Center(
                  child: Text(
                    'Primeiro acesso',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.5 * ffem / fem,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
