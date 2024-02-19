import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/presential_consultation/widgets/discount_info_bottom_sheet/widgets/discount_header.dart';
import 'package:omni_core/src/app/modules/presential_consultation/widgets/discount_info_bottom_sheet/widgets/discount_info_widget.dart';
import 'package:omni_general/omni_general.dart';

class DiscountsInfoBottomSheet extends StatefulWidget {
  const DiscountsInfoBottomSheet({Key? key}) : super(key: key);

  @override
  State<DiscountsInfoBottomSheet> createState() => _DiscountsInfoBottomSheetState();
}

class _DiscountsInfoBottomSheetState extends State<DiscountsInfoBottomSheet> {
  final List<DiscountInfo> discounts = getDiscountInfos();
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      width: double.maxFinite,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            left: 0,
                            top: 0,
                            child: Text(
                              'Exames e consultas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: -10,
                            child: IconButton(
                              onPressed: () => Modular.to.pop(),
                              icon: Icon(
                                Icons.close,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Descontos oferecidos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Demais serviços não listados possuem 10% de desconto',
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff696969),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              ExpansionPanelList(
                elevation: 0,
                dividerColor: Colors.grey,
                expandIconColor: Theme.of(context).primaryColor,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    discounts[index].isExpanded = !isExpanded;
                  });
                },
                children: discounts.map<ExpansionPanel>((DiscountInfo DiscountInfo) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return DiscountHeader(
                        title: DiscountInfo.title,
                        value: DiscountInfo.value,
                        subtitle: DiscountInfo.subtitle,
                        parcels: DiscountInfo.parcels,
                      );
                    },
                    body: DiscountInfoWidget(info: DiscountInfo),
                    isExpanded: DiscountInfo.isExpanded,
                  );
                }).toList(),
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<DiscountInfo> getDiscountInfos() {
  return [
    DiscountInfo(
      'Gestação',
      [
        'Hemograma',
        'Tipagem sanguínea e fator Rh Coombs indireto (se for Rh negativo)',
        'Glicemia em jejum',
        'Teste rápido de triagem para sífilis e/ou VDRL/RPR',
        'Teste rápido diagnóstico anti-HIV - Anti-HIV Toxoplasmose IgM e IgG',
        'Sorologia para hepatite B (HbsAg)',
        'Urocultura',
        'Urina tipo I (sumário de urina – SU, EQU)',
        'TSH'
      ],
      value: 'De R\$450 por R\$370',
      subtitle: 'Pacote 1o trimestre',
      parcels: '(3x sem juros)',
    ),
    DiscountInfo(
      'Gestação',
      [
        'Hemograma',
        'Glicemia em jejum',
        'Coombs indireto (se for Rh negativo)',
        'VDRL Anti-HIV',
        'Sorologia para hepatite B (HbsAg)',
        'Toxoplasmose se o IgG não for reagente',
        'Urocultura',
        'Urina tipo I (sumário de urina – SU)',
        'Bacterioscopia de secreção vaginal (a partir de 37 semanas de gestação',
      ],
      value: 'De R\$427 por R\$360',
      subtitle: 'Pacote 3o trimestre',
      parcels: '(3x sem juros)',
    ),
    DiscountInfo('Outros exames e consultas', [
      'Consulta clínico geral: de R\$100 por R\$90',
      'Hemograma: de R\$39 por R\$24',
      'Exame de Urina (EAS): por R\$23',
      'Eletrocardioagrama: por R\$45',
      'Papanicolau: por R\$47',
      'Sangue oculto (fezes): por R\$34',
      'USG Pélvica transvaginal: por R\$125',
      'USG Tireoide: por R\$125',
    ]),
  ];
}
