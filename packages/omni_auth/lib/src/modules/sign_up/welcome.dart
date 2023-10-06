import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/already_have_account.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/horizontal_divider.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/social_login_buttons.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/terms_policies_widget.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Container(
              // welcomeKrf (4511:30447)
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupkvljjfV (MYmFKmRdKm5K5NYZsWKVLj)
                    padding: EdgeInsets.fromLTRB(
                        0 * fem, 20 * fem, 0 * fem, 7 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // frame2Spo (5101:11624)
                          margin: EdgeInsets.fromLTRB(
                              19 * fem, 0 * fem, 38 * fem, 28 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // welcomeMgs (5101:11625)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                child: Text(
                                  'Bem-vindo',
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
                                // toregisteranaccountpleasefilli (5101:11626)
                                constraints: BoxConstraints(
                                  maxWidth: 297 * fem,
                                ),
                                child: Text(
                                  'Para registrar uma conta, preencha os campos abaixo.',
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
                        const WelcomeForm(),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: 335 * fem,
                          height: 56 * fem,
                          decoration: BoxDecoration(
                            color: true
                                ? const Color(0xff2D73B3)
                                : Color(0xffbbd2e6),
                            borderRadius: BorderRadius.circular(60 * fem),
                          ),
                          child: InkWell(
                            onTap: () {
                              debugger();
                              // Modular.to.pushNamed('/emailConfirmation');
                              Navigator.pushNamed(
                                  context, '/auth/signUp/emailConfirmation');
                            },
                            child: Container(
                              // autogroupvztqGaB (MYmGTQCvwMsEchRfLGVzTq)

                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                child: Text(
                                  'Cadastrar',
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
                        const SizedBox(
                          height: 24,
                        ),
                        const TermsPoliciesWidget(),
                        const HorizontalDivider(),
                        const SizedBox(
                          height: 24,
                        ),
                        const SocialLoginButton(),
                        const AlreadyHaveAccount(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
