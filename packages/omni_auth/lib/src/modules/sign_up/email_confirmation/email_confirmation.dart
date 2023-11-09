import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_auth/src/modules/sign_up/email_confirmation/widgets/gmail_button.dart';
import 'package:omni_core/omni_core.dart';

class EmailConfirmation extends StatelessWidget {
  EmailConfirmation();
  final RegisterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          // emailconfirmationeT9 (201:17386)
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // autogroupatg3uP5 (MYqgYxeqcSJjrbDiweATG3)
                padding: EdgeInsets.fromLTRB(0 * fem, 44 * fem, 0 * fem, 7 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroup88ufRMR (MYqgRoC7CyQ2q5vfYr88Uf)
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            // width: 335 * fem,
                            height: 300,
                            child: SvgPicture.asset(
                              Assets.logoSplash,
                              // package: AssetsPackage.omniGeneral,
                              // width: 335 * fem,
                              // height: 328 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // almostthereM8b (201:17390)
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 13 * fem),
                      child: Text(
                        'Quase lá',
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
                      // confirmyouridentitybyclickingt (201:17391)
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 0 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 312 * fem,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.6000000238 * ffem / fem,
                            color: Color(0xff52576a),
                          ),
                          children: [
                            const TextSpan(
                              text: 'Confirme seu cadastro clicando no link enviado para ',
                            ),
                            TextSpan(
                              text: store.state.individualPerson?.user?.email,
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.6000000238 * ffem / fem,
                                color: Color(0xff2d72b3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GmailButton()
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
