import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/ui/welcome/widgets/already_have_account.dart';
import 'package:myapp/ui/welcome/widgets/horizontal_divider.dart';
import 'package:myapp/ui/welcome/widgets/terms_policies_widget.dart';
import 'package:myapp/ui/welcome/widgets/welcome_form.dart';
import 'package:myapp/utils.dart';

import 'widgets/social_login_buttons.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
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
                padding:
                    EdgeInsets.fromLTRB(0 * fem, 40 * fem, 0 * fem, 7 * fem),
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
                              'Welcome',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
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
                              'To register an account, please fill in the fields below.',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
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
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          128 * fem, 16 * fem, 138 * fem, 16 * fem),
                      width: 335 * fem,
                      height: 56 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xffbbd2e6),
                        borderRadius: BorderRadius.circular(60 * fem),
                      ),
                      child: Container(
                        // autogroupvztqGaB (MYmGTQCvwMsEchRfLGVzTq)
                        padding: EdgeInsets.fromLTRB(
                            10 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.5 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const TermsPoliciesWidget(),
                    const HorizontalDivider(),
                    const SocialLoginButton(),
                    const AlreadyHaveAccount(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
