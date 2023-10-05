import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // pleasetypeapasswordforyouracco (201:17501)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Please type a password for your account',
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2999999306 * ffem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              WelcomeFormField(
                label: 'Password',
              ),
              Container(
                // captionoLb (I201:17512;1302:19293;1302:19102)
                margin:
                    EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Minimum 8 characters with at least a number, \ncapital letter and symbol',
                  style: TextStyle(
                    fontSize: 12 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.3333333333 * ffem / fem,
                    color: Color(0xff878da0),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                // buttonprimaryJHM (202:13947)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 394 * fem),
                child: TextButton(
                  onPressed: () {
                    Modular.to.pushNamed('/auth/signUp/signUpPage');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 56 * fem,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff2d72b3),
                        borderRadius: BorderRadius.circular(60 * fem),
                      ),
                      child: Container(
                        // autogroupej3hLUw (MYqhTWybfzWVF6h6TyeJ3h)
                        padding: EdgeInsets.fromLTRB(
                            4 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            'Continue',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
