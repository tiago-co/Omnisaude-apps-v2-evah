import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';

class EvolutionformHeaderwidget extends StatelessWidget {
  final String bed;
  final String attendanceNumber;
  const EvolutionformHeaderwidget({
    Key? key,
    required this.bed,
    required this.attendanceNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowTextFieldWidget(
          label: 'Leito',
          value: bed,
        ),
        RowTextFieldWidget(
          label: 'Número de Atendimento',
          value: attendanceNumber,
        )
      ],
    );
  }
}
