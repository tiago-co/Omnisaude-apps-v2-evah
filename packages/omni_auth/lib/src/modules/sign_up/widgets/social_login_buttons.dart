import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // autogroupqpovnko (MYmF9wNfqcUm4f14wJQPoV)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 48 * fem,
              decoration: BoxDecoration(
                color: const Color(0xff1877F2),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: const Color(0xffEEEEF2),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.facebookIcon,
                  package: AssetsPackage.omniGeneral,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              // socialbuttonoA7 (4511:30461)
              width: 159 * fem,
              height: 48 * fem,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: const Color(0xffEEEEF2),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.googleIcon,
                  package: AssetsPackage.omniGeneral,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
