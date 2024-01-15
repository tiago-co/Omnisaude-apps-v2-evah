import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0 * fem, 20 * fem, 0 * fem, 7 * fem),
          child: Column(children: [
            Container(
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
                      'Faça agendamentos e \nacompanhe seus compromissos.',
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
            SizedBox(
              height: 32 * fem,
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: constraints.maxWidth,
                child: SvgPicture.asset(
                  Assets.onboarding2,
                  package: AssetsPackage.omniCore,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ]),
        );
      },
    );
  }
}
