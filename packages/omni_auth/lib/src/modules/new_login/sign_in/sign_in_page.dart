import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/login/stores/login_store.dart';
import 'package:omni_auth/src/modules/new_login/store/new_login_store.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_login_labels/labels.dart';

class SignInPage extends StatelessWidget {
  SignInPage();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final NewLoginStore store = Modular.get();

  void login(BuildContext context) {
    store.authenticate(store.state).then(
      (value) {
        Modular.to.pushReplacementNamed('/newHome');
      },
    ).catchError(
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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20 * fem, 40 * fem, 1 * fem, 7 * fem),
          // signinMNF (4511:30462)
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // frame26UF (4511:30466)
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
                      label: 'E-mail',
                      controller: username,
                      focusNode: usernameFocus,
                      focusedborder: InputBorder.none,
                      padding: EdgeInsets.zero,
                      textCapitalization: TextCapitalization.none,
                      onChange: (String? input) {
                        store.state.username = input;
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
                      onTap: () => Modular.to.pushNamed('/auth/newLogin/resetPassword'),
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
                  // masterbuttonmaster82s (I4511:30472;19:7770)
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 19 * fem, 0 * fem),
                  padding: EdgeInsets.fromLTRB(0 * fem, 16 * fem, 0 * fem, 16 * fem),

                  height: 56 * fem,
                  decoration: BoxDecoration(
                    color: true ? Color(0xff2D73B3) : Color(0xff2d72b3),
                    borderRadius: BorderRadius.circular(60 * fem),
                  ),
                  child: Container(
                    // autogroupfwxxDa7 (MYmMmLCB3rKy918MJrfWxX)
                    padding: EdgeInsets.fromLTRB(13 * fem, 0 * fem, 0 * fem, 0 * fem),
                    width: double.infinity,
                    height: double.infinity,
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
                  ),
                ),
              ),
              const Spacer(),
              Center(
                // donthaveanaccountsignupWJK (4511:30474)
                child: Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 19 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {
                      Modular.to.pushReplacementNamed('/auth/signUp/');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        children: [
                          TextSpan(
                            text: 'Não possui conta?',
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.6000000238 * ffem / fem,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff2d72b3),
                            ),
                          ),
                          TextSpan(
                            text: 'Cadastre-se',
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff2d72b3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
