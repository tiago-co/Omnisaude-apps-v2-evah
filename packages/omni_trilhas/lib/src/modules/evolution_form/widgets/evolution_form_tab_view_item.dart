import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';

class EvolutionFormTabViewItem extends StatelessWidget {
  final EvolutionFormModel evolutionForm;
  const EvolutionFormTabViewItem({
    Key? key,
    required this.evolutionForm,
  }) : super(key: key);

  String get formatDateTimeToHumanized {
    String dateFormatyMd = Formaters.dateToStringDateTime(
      Formaters.stringToDateTime(evolutionForm.createdAt!),
    );

    return dateFormatyMd.replaceAll(' ', ' às ');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        'evolution_details',
        arguments: evolutionForm,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 1,
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Número de Atendimento: ${evolutionForm.attendanceNumber}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Data: $formatDateTimeToHumanized',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      if (evolutionForm.filedBy!.nome != null)
                        Text(
                          'Preenchido por: ${evolutionForm.filedBy?.nome}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
