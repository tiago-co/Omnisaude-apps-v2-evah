import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/omni_general.dart';

import 'service_button.dart';

class ServicesWidget extends StatelessWidget {
  ServicesWidget();
  final UserStore userStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

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
                  padding: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => Modular.to.pushNamed('/newHome/services'),
                    child: Text(
                      'Ver tudo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
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
          height: 105 * fem,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 16 * fem, bottom: 10),
            children: [
              AspectRatio(
                aspectRatio: (110 / 65),
                child: InkWell(
                  onTap: () {
                    Modular.to.pushNamed(
                      '/newHome/teleattendanceUrgency',
                      arguments: 'Pronto Atendimento',
                    );
                  },
                  child: ServiceButton(
                    color: const Color(0xffedf5fc),
                    image: SvgPicture.asset(
                      Assets.consultationIcon,
                      package: AssetsPackage.omniCore,
                    ),
                    title: 'Pronto Atendimento',
                  ),
                ),
              ),
              SizedBox(width: 8 * fem),
              AspectRatio(
                aspectRatio: (110 / 65),
                child: InkWell(
                  onTap: () {
                    Modular.to.pushNamed('/newHome/new_chatbot_webview');
                  },
                  child: ServiceButton(
                    color: const Color(0xffECF9F6),
                    image: SvgPicture.asset(
                      Assets.mentalCareIcon,
                      package: AssetsPackage.omniCore,
                    ),
                    title: 'Enfermeira Virtual',
                  ),
                ),
              ),
              // ServiceButton(
              //   image: SvgPicture.asset(
              //     Assets.selfAssessmentIcon,
              //     package: AssetsPackage.omniCore,
              //   ),
              //   title: 'Saúde da mulher',
              //   inverted: true,
              // ),
              // const SizedBox(width: 8),
              // ServiceButton(
              //   color: const Color(0xffECF9F6),
              //   image: SvgPicture.asset(
              //     Assets.selfAssessmentIcon,
              //     package: AssetsPackage.omniCore,
              //   ),
              //   inverted: true,
              //   title: 'Auto-avaliação ',
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
