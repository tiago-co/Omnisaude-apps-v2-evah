import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/pages/evolution_form_details_page/widgets/generic_evolution_details_widget.dart';
import 'package:omni_trilhas/src/modules/evolution_form/pages/evolution_form_details_page/widgets/medical_evolution_details_widget.dart';
import 'package:omni_trilhas/src/modules/evolution_form/pages/evolution_form_details_page/widgets/nurse_evolution_details_widget.dart';

class EvolutionFormDetailsPage extends StatelessWidget {
  final EvolutionFormModel evolutionForm;
  const EvolutionFormDetailsPage({
    Key? key,
    required this.evolutionForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: evolutionForm.attendanceNumber!)
          .build(context) as AppBar,
      body: _getDetailsWidgetByType(evolutionForm),
    );
  }
}

Widget _getDetailsWidgetByType(EvolutionFormModel evolutionForm) {
  switch (evolutionForm.evolutionFormType!) {
    case EvolutionFormType.doctor:
      return MedicalEvoltuionDetailPage(evolutionFormId: evolutionForm.id!);
    case EvolutionFormType.nursing:
      return NurseEvoltuionDetailWidget(
        evolutionFormId: evolutionForm.id!,
      );
    default:
      return GenericEvolutionDetailsWidget(
        id: evolutionForm.id!,
        evolutionFormType: evolutionForm.evolutionFormType!,
      );
  }
}
