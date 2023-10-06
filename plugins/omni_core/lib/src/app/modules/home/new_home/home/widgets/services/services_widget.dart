import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';

import 'service_button.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget();

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
                  'Serviços',
                  style: TextStyle(
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
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () => Modular.to.pushNamed('/newHome/services'),
                    child: Text(
                      'Ver tudo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.5 * ffem / fem,
                        color: Color(0xff52576a),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 100,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 16),
            children: [
              ServiceButton(
                image: SvgPicture.asset(
                  Assets.consultationIcon,
                  package: AssetsPackage.omniCore,
                ),
                title: 'Consultas',
              ),
              const SizedBox(width: 8),
              ServiceButton(
                image: SvgPicture.asset(
                  Assets.selfAssessmentIcon,
                  package: AssetsPackage.omniCore,
                ),
                title: 'Saúde da mulher',
                inverted: true,
              ),
              const SizedBox(width: 8),
              ServiceButton(
                image: SvgPicture.asset(
                  Assets.mentalCareIcon,
                  package: AssetsPackage.omniCore,
                ),
                title: 'Auto-avaliação ',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
