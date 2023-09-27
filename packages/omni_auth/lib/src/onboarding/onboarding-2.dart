import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // onboarding2H9R (4511:30436)
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupvp7mghM (MYmECddVQuyV6XLRx1VP7M)
              padding:
                  EdgeInsets.fromLTRB(20 * fem, 40 * fem, 20 * fem, 7 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // frame1anj (4511:30437)
                    margin: EdgeInsets.fromLTRB(
                        36 * fem, 0 * fem, 36 * fem, 74 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // trackyourqueriesi8F (4511:30438)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 4 * fem),
                          child: Text(
                            'Track your queries',
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
                          // makeappointmentsandtrackyourap (4511:30439)
                          constraints: BoxConstraints(
                            maxWidth: 263 * fem,
                          ),
                          child: Text(
                            'Make appointments and track your appointments.',
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
                  Container(
                    // medico2021UWj (5304:19267)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 50 * fem),
                    width: 335 * fem,
                    height: 328 * fem,
                    child: Image.asset(
                      'assets/ui/images/medico2-02-1.png',
                      width: 335 * fem,
                      height: 328 * fem,
                    ),
                  ),
                  Container(
                    // frame33186NMD (5321:25819)
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 0 * fem, 0 * fem, 52 * fem),
                    width: 18 * fem,
                    height: 6 * fem,
                    child: Image.asset(
                      'assets/ui/images/frame-33186-Qdd.png',
                      width: 18 * fem,
                      height: 6 * fem,
                    ),
                  ),
                  Container(
                    // buttonprimaryU9M (4511:30440)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 60 * fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 56 * fem,
                        child: Container(
                          // masterbuttonmasterBZZ (I4511:30440;19:7388)
                          padding: EdgeInsets.fromLTRB(
                              128 * fem, 16 * fem, 134.5 * fem, 16 * fem),
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xff2d72b3),
                            borderRadius: BorderRadius.circular(60 * fem),
                          ),
                          child: Container(
                            // autogroupdwo5VKM (MYmEasVSBSEkWkj3SHdwo5)
                            padding: EdgeInsets.fromLTRB(
                                6.5 * fem, 0 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                'Let\'s go!',
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
                  Container(
                    // rectangle21Za7 (I4511:30443;42:8743;246:1080)
                    margin: EdgeInsets.fromLTRB(
                        100.5 * fem, 0 * fem, 100.5 * fem, 0 * fem),
                    width: double.infinity,
                    height: 5 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * fem),
                      color: Color(0xff1a1c22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
