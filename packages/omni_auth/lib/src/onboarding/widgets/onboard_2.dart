import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

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
          // frame1anj (4511:30437)
          margin: EdgeInsets.fromLTRB(36 * fem, 0 * fem, 36 * fem, 74 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // trackyourqueriesi8F (4511:30438)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
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
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
          width: 335 * fem,
          height: 328 * fem,
          child: Image.asset(
            'assets/ui/images/medico2-02-1.png',
            width: 335 * fem,
            height: 328 * fem,
          ),
        ),
      ]),
    );
  }
}
