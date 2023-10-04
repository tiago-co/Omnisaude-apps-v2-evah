import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20 * fem, 0 * fem, 1 * fem, 7 * fem),
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
                margin: EdgeInsets.fromLTRB(
                    14.5 * fem, 0 * fem, 33.5 * fem, 28 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // welcomebackdDH (4511:30467)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      child: Text(
                        'Welcome back',
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
                        'Enter your access data and we will take care of better taking care of your health.',
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
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 28 * fem),
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeFormField(label: 'E-mail'),
                    SizedBox(
                      height: 12,
                    ),
                    WelcomeFormField(label: 'Senha'),
                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () =>
                          Modular.to.pushNamed('/auth/newLogin/resetPassword'),
                      child: Text(
                        'Forgot password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.6000000238 * ffem / fem,
                          color: true ? Color(0xff2D73B3) : Color(0xff2d72b3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // masterbuttonmaster82s (I4511:30472;19:7770)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 19 * fem, 198 * fem),
                padding: EdgeInsets.fromLTRB(
                    128 * fem, 16 * fem, 141 * fem, 16 * fem),
                width: 335 * fem,
                height: 56 * fem,
                decoration: BoxDecoration(
                  color: Color(0xffbbd2e6),
                  borderRadius: BorderRadius.circular(60 * fem),
                ),
                child: Container(
                  // autogroupfwxxDa7 (MYmMmLCB3rKy918MJrfWxX)
                  padding:
                      EdgeInsets.fromLTRB(13 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'Sign In',
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
              Center(
                // donthaveanaccountsignupWJK (4511:30474)
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 19 * fem, 32 * fem),
                  child: TextButton(
                    onPressed: () {},
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
                            text: 'Don’t have an account?',
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
                            text: 'Sign up',
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
