import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          // signupstep2passwordpfh (201:17474)
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // pleasetypeapasswordforyouracco (201:17501)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                constraints: BoxConstraints(
                  maxWidth: 288 * fem,
                ),
                child: Text(
                  'Please type a password for your account',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2999999306 * ffem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              Container(
                // autogroupzmvww83 (MYqh17ZviXV6AE3ApVZmvw)
                padding:
                    EdgeInsets.fromLTRB(0 * fem, 32 * fem, 1 * fem, 7 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // masterinputTMH (I201:17512;1302:19293)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 56 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // yKd (I201:17512;1302:19293;1302:19093)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 8 * fem),
                            padding: EdgeInsets.fromLTRB(
                                24 * fem, 15 * fem, 24 * fem, 7 * fem),
                            width: double.infinity,
                            height: 56 * fem,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffededf1)),
                              borderRadius: BorderRadius.circular(60 * fem),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroup7cgfGi3 (MYqhG78wo8DxxYBtzS7cgf)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 187 * fem, 0 * fem),
                                  width: 76 * fem,
                                  height: double.infinity,
                                  child: Container(
                                    // aTq (I201:17512;1302:19293;1302:19095)
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Text(
                                      'Password',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.6000000238 * ffem / fem,
                                        color: Color(0xff878da0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // eyeoffV51 (I201:17512;1302:19293;1302:19098)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/ui/images/eye-off-K3m.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // captionoLb (I201:17512;1302:19293;1302:19102)
                            margin: EdgeInsets.fromLTRB(
                                24 * fem, 0 * fem, 0 * fem, 0 * fem),
                            constraints: BoxConstraints(
                              maxWidth: 262 * fem,
                            ),
                            child: Text(
                              'Minimum 8 characters with at least a number, \ncapital letter and symbol',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333 * ffem / fem,
                                color: Color(0xff878da0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // buttonprimaryJHM (202:13947)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 394 * fem),
                      child: TextButton(
                        onPressed: () {},
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
                        ),
                      ),
                    ),
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
