import 'dart:io';

import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/dr_pra_voce/exams_consultations_widget.dart';
import 'package:omni_core/src/app/modules/presential_consultation/widgets/presential_consultation_info.dart';
import 'package:url_launcher/url_launcher.dart';

class DraPraVoce extends StatefulWidget {
  const DraPraVoce({Key? key}) : super(key: key);

  @override
  State<DraPraVoce> createState() => _DraPraVoceState();
}

class _DraPraVoceState extends State<DraPraVoce> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Especialidades',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const ExamsConsultationWidget(),
        const SizedBox(height: 24),
        const PresentialConsultationInfo(),
        const SizedBox(height: 24),
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
            'Agendar Exame',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              decorationColor: Colors.white,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      ],
    );
  }
}
