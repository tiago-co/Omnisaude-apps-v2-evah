import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

import 'widgets/sign_up_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // masternavigationbarmasterbf5 (I4511:30504;14:1667)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
                  padding: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 3.25 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // autogroupmb1zC95 (MYmRYUQ2fAy1BDAFBRMb1Z)
                        margin: EdgeInsets.fromLTRB(
                            20 * fem, 0 * fem, 20 * fem, 0 * fem),
                        width: double.infinity,
                        height: 40.5 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // lefti7R (I4511:30504;14:1667;14:1584)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 8.75 * fem, 71.5 * fem, 5.75 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 1 * fem, 0 * fem, 1 * fem),
                              width: 72 * fem,
                              height: double.infinity,
                              child: Align(
                                // arrowbackioscib (I4511:30504;14:1667;14:1585)
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 48 * fem, 0 * fem),
                                    child: Image.asset(
                                      'assets/ui/images/arrowbackios-dD1.png',
                                      width: 24 * fem,
                                      height: 24 * fem,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // frame167y (I4511:30504;14:1667;14:1587)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 78.5 * fem, 0 * fem),
                              width: 48 * fem,
                              height: double.infinity,
                            ),
                            Container(
                              // rightEEB (I4511:30504;14:1667;14:1590)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 8.75 * fem, 0 * fem, 5.75 * fem),
                              width: 65 * fem,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // pleasefillinallfieldstocomplet (4511:30507)
                  margin:
                      EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 0 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 248 * fem,
                  ),
                  child: Text(
                    'Please fill in all fields to complete registration',
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
                  // autogroupga3rDM1 (MYmNg4BKgKm5iLVNgHGA3R)
                  padding:
                      EdgeInsets.fromLTRB(20 * fem, 28 * fem, 1 * fem, 7 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // frame3ioZ (4511:30508)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 4 * fem),
                        width: double.infinity,
                        height: 556 * fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // masterinputqtB (I5101:11928;1302:19329)
                              left: 0 * fem,
                              top: 0 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // inputQTR (5101:11764)
                              left: 0 * fem,
                              top: 68 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // masterinputd7D (I4511:30510;1302:19305)
                              left: 0 * fem,
                              top: 136 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // masterinputzEb (I4511:30511;1302:19305)
                              left: 0 * fem,
                              top: 204 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // masterinputNuM (I4511:30512;1302:19305)
                              left: 0 * fem,
                              top: 272 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // masterinputedu (I4511:30513;1302:19305)
                              left: 0 * fem,
                              top: 340 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // masterinputFvX (I4511:30514;1302:19305)
                              left: 0 * fem,
                              top: 408 * fem,
                              child: const SignUpField(),
                            ),
                            Positioned(
                              // masterinputeLP (I4511:30515;1302:19305)
                              left: 0 * fem,
                              top: 476 * fem,
                              child: const SignUpField(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // masterbuttonmasterPqh (I4511:30516;19:7770)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 34 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 16 * fem, 0.5 * fem, 16 * fem),

                        height: 56 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xffbbd2e6),
                          borderRadius: BorderRadius.circular(60 * fem),
                        ),
                        child: Container(
                          // autogroupu5ougpo (MYmRPPppj9ubWD8BZ7U5ou)
                          padding: EdgeInsets.fromLTRB(
                              1.5 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              'Complete',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
