import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

import 'service_button.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4 * fem),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  'Services ',
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4 * fem),
                ),
                child: Container(
                  child: Center(
                    child: Center(
                      child: Text(
                        'See all',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.5 * ffem / fem,
                          color: Color(0xff52576a),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 100 * fem,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ServiceButton(
                image: '',
                title: '',
              ),
              SizedBox(
                width: 8 * fem,
              ),

              // TextButton(
              //   // frame1529D5H (4701:10689)
              //   onPressed: () {},
              //   style: TextButton.styleFrom(
              //     padding: EdgeInsets.zero,
              //   ),
              //   child: Container(
              //     width: 140 * fem,
              //     height: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Color(0xffe9f7fc),
              //       borderRadius: BorderRadius.circular(12 * fem),
              //     ),
              //     child: Stack(
              //       children: [
              //         Positioned(
              //           // selfassessmentVoV (4701:10691)
              //           left: 16 * fem,
              //           top: 46 * fem,
              //           child: Align(
              //             child: SizedBox(
              //               width: 84 * fem,
              //               height: 58 * fem,
              //               child: Text(
              //                 'Self-assessment',
              //                 style: SafeGoogleFont(
              //                   'Inter',
              //                   fontSize: 16 * ffem,
              //                   fontWeight: FontWeight.w500,
              //                   height: 1.2000000477 * ffem / fem,
              //                   color: Color(0xff1a1c22),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           // mediconahora02yTm (4701:10692)
              //           left: 54.9765625 * fem,
              //           top: -18.0064697266 * fem,
              //           child: Align(
              //             child: SizedBox(
              //               width: 75.36 * fem,
              //               height: 70.79 * fem,
              //               child: Image.asset(
              //                 'assets/ui/images/medico-na-hora-02-7Ls.png',
              //                 width: 75.36 * fem,
              //                 height: 70.79 * fem,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(
                width: 8 * fem,
              ),

              // TextButton(
              //   // frame1529Ss9 (4701:10694)
              //   onPressed: () {},
              //   style: TextButton.styleFrom(
              //     padding: EdgeInsets.zero,
              //   ),
              //   child: Container(
              //     padding: EdgeInsets.fromLTRB(
              //         16 * fem, 16 * fem, 18.29 * fem, 0 * fem),
              //     width: 140 * fem,
              //     height: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Color(0xffecf9f6),
              //       borderRadius: BorderRadius.circular(12 * fem),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           // mentalcarejLT (4701:10696)
              //           margin: EdgeInsets.fromLTRB(
              //               0 * fem, 0 * fem, 14.71 * fem, 8.53 * fem),
              //           child: Text(
              //             'Mental care',
              //             style: SafeGoogleFont(
              //               'Inter',
              //               fontSize: 16 * ffem,
              //               fontWeight: FontWeight.w500,
              //               height: 1.6000000238 * ffem / fem,
              //               color: Color(0xff1a1c22),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           // mediconahora03E2K (4701:10697)
              //           margin: EdgeInsets.fromLTRB(
              //               35.05 * fem, 0 * fem, 0 * fem, 0 * fem),
              //           width: 70.67 * fem,
              //           height: 59.87 * fem,
              //           child: Image.asset(
              //             'assets/ui/images/medico-na-hora-03-tAT.png',
              //             width: 70.67 * fem,
              //             height: 59.87 * fem,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
