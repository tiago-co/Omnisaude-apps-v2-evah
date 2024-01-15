import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/services/service_button.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double baseWidth = 375;
    final double fem = MediaQuery.of(context).size.width / baseWidth;
    final double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Serviços',
                style: TextStyle(
                  fontSize: 22 * fem,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 12 * fem,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saúde',
                style: TextStyle(
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8 * fem,
                crossAxisSpacing: 8 * fem,
                childAspectRatio: (100 / 65),
              ),
              children: [
                InkWell(
                  onTap: () {
                    Modular.to.pushNamed('/newHome/teleattendanceUrgency', arguments: 'Pronto Atendimento');
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
                InkWell(
                  onTap: () {
                    Modular.to.pushNamed('/newHome/mediktor/historic', arguments: 'Auto Avaliação');
                  },
                  child: ServiceButton(
                    color: const Color(0xffE9F7FC),
                    image: SvgPicture.asset(
                      Assets.selfAssessmentIcon,
                      package: AssetsPackage.omniCore,
                    ),
                    title: 'Auto-avaliação',
                    inverted: true,
                  ),
                ),
                InkWell(
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
              ],
            ),
            SizedBox(
              height: 24 * fem,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Descontos',
                style: TextStyle(
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 12 * fem,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8 * fem,
                crossAxisSpacing: 8 * fem,
                childAspectRatio: (100 / 65),
              ),
              children: [
                InkWell(
                  onTap: () {
                    Modular.to.pushNamed(
                      '/newHome/discounts/cupons',
                      arguments: {
                        // 'moduleName': 'Desconto em Farmácia',
                        'categoryParam': '19',
                        'organizationId': 0,
                        'moduleName': 'Desconto em Farmácias',
                        'coverImage': '',
                        'couponRescueType': '',
                      },
                    );
                  },
                  child: ServiceButton(
                    color: const Color(0xffFFF0F0),
                    image: SvgPicture.asset(
                      Assets.pillFilledIcon,
                      package: AssetsPackage.omniCore,
                    ),
                    title: 'Farmácias',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Modular.to.pushNamed(
                      '/newHome/discounts/cupons',
                      arguments: {
                        // 'moduleName': 'Desconto em Farmácia',
                        'categoryParam': '',
                        'organizationId': 0,
                        'moduleName': 'Outros descontos',
                        'coverImage': '',
                        'couponRescueType': '',
                      },
                    );
                  },
                  child: ServiceButton(
                    color: const Color(0xffEDF7F8),
                    image: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        Assets.firstAidBagIcon,
                        package: AssetsPackage.omniCore,
                        width: 62,
                        color: Color(0xffBAE7E8),
                      ),
                    ),
                    title: 'Outros',
                    inverted: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
