import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({Key? key}) : super(key: key);

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
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // trackyourqueriesi8F (4511:30438)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Acompanhe suas consultas',
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
                // makeappointmentsandtrackyourap (4511:30439)

                child: Text(
                  'Faça agendamentos e acompanhe seus compromissos.',
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
          // medico2021UWj (5304:19267)
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
          child: SvgPicture.asset(
            Assets.onboarding2,
            package: AssetsPackage.omniCore,
          ),
        ),
      ]),
    );
  }
}
