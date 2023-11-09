import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:url_launcher/url_launcher.dart';

class GmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 301;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return InkWell(
      // onTap: () => Modular.to.pushNamed('/auth/signUp/password'),
      onTap: () => launchUrl(
        Uri.parse('https://mail.google.com/mail/?q=from:atendimento@evahsaude.com.br'),
        mode: LaunchMode.externalApplication,
      ),
      child: Container(
        // masterbuttonmaster2P1 (I202:13935;201:22697)
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0.5 * fem, 16 * fem, 0.5 * fem, 16 * fem),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffededf1)),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(60 * fem),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // iconssocialiconsvjH (I202:13935;201:22697;19:7257)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 20 * fem,
                height: 20 * fem,
                child: SvgPicture.asset(
                  Assets.googleIcon,
                  package: AssetsPackage.omniGeneral,
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Abrir Gmail',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                  // openinnewweP (I202:13935;201:22697;19:7261)
                  width: 24 * fem,
                  height: 24 * fem,
                  child: Icon(
                    Icons.ios_share_rounded,
                    size: 24,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
