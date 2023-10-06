import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/services/service_button.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Serviços',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              children: [
                ServiceButton(
                  image: SvgPicture.asset(
                    Assets.consultationIcon,
                    package: AssetsPackage.omniCore,
                  ),
                  title: 'Consultas',
                ),
                ServiceButton(
                  image: SvgPicture.asset(
                    Assets.selfAssessmentIcon,
                    package: AssetsPackage.omniCore,
                  ),
                  title: 'Auto-avaliação',
                  inverted: true,
                ),
                ServiceButton(
                  image: SvgPicture.asset(
                    Assets.mentalCareIcon,
                    package: AssetsPackage.omniCore,
                  ),
                  title: 'Cuidados ',
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Descontos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              children: [
                ServiceButton(
                  image: SvgPicture.asset(
                    Assets.consultationIcon,
                    package: AssetsPackage.omniCore,
                  ),
                  title: 'Farmácias',
                ),
                ServiceButton(
                  image: SvgPicture.asset(
                    Assets.selfAssessmentIcon,
                    package: AssetsPackage.omniCore,
                  ),
                  title: 'Exames',
                  inverted: true,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
