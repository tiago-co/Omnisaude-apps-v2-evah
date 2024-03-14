import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/presential_consultation/widgets/presential_consultation_info.dart';
import 'package:omni_general/omni_general.dart';
import 'package:url_launcher/url_launcher.dart';

import '../new_discounts/widgets/discount_detail_item.dart';

class PresentialConsultationPage extends StatefulWidget {
  PresentialConsultationPage({Key? key}) : super(key: key);

  @override
  State<PresentialConsultationPage> createState() => _PresentialConsultationPageState();
}

class _PresentialConsultationPageState extends State<PresentialConsultationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 35,
            color: Colors.black87,
          ),
          onPressed: () {
            //dessa maneira quando retornar pelo deep-link, não vai cair
            //em uma tela vazia
            Modular.to.pushReplacementNamed('/newHome/');
          },
        ),
        centerTitle: true,
        title: const Text(
          'Consultas presenciais',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.375,
                  child: Image.asset(
                    Assets.presentialConsultationService,
                    package: AssetsPackage.omniCore,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Dr. Pra Você',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    String text = '';
                    if (Platform.isAndroid) {
                      text =
                          'whatsapp://send?&phone=556239280123&text=Olá, sou assinante da Evah Saúde e gostaria de informações sobre os descontos';
                    } else {
                      text =
                          'https://wa.me/+556239280123?text=Olá, sou assinante da Evah Saúde e gostaria de informações sobre os descontos';
                    }
                    await launchUrl(
                      Uri.parse(text),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Text(
                    'Agendar Consulta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      decorationColor: Colors.white,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                // const SizedBox(height: 24),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Especialidades',
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.grey.shade800,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 16),
                // const ExamsConsultationWidget(),
                const SizedBox(height: 24),
                DiscountDetailItem(
                  title: 'Até 15% off em consultas',
                  cupom: CupomModel(
                    discount: 15,
                    endDate: '2024-12-31',
                    organizationId: 0,
                  ),
                ),
                const SizedBox(height: 24),
                const PresentialConsultationInfo(),

                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Como agendar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Entre em contato pelo WhatsApp da Dr. Para Você e diga que é assinante da Evah Saúde',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
