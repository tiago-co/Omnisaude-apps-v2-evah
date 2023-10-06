import 'package:flutter/material.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // autogroupjqst3QT (MYmCYRtneuQ2ogY6gZJQST)
      padding: EdgeInsets.fromLTRB(20 * fem, 40 * fem, 20 * fem, 7 * fem),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          // frame1Ksm (4511:30422)
          margin:
              EdgeInsets.fromLTRB(24.5 * fem, 0 * fem, 24.5 * fem, 40 * fem),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // manageyourhealththeeasyway2XH (4511:30423)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                constraints: BoxConstraints(
                  maxWidth: 269 * fem,
                ),
                child: Text(
                  'Manage your health\nthe easy way',
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
                // accessdiscountsonmedicationsan (4511:30424)
                constraints: BoxConstraints(
                  maxWidth: 286 * fem,
                ),
                child: Text(
                  'Access discounts on medications and exams and appointments.',
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
        Image.asset(
          'assets/ui/images/medico2-01-1.png',
        ),
      ]),
    );
  }
}
