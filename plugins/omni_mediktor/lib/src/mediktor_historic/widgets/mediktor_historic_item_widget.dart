import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show VerticalTimelineItemWidget, Formaters;
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';

import 'package:omni_mediktor/src/mediktor_historic/widgets/mediktor_urgency_widget.dart';

class MediktorHistoricItemWidget extends StatelessWidget {
  final MediktorDiagnosisModel diagnose;
  const MediktorHistoricItemWidget({
    Key? key,
    required this.diagnose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalTimelineItemWidget(
      child: GestureDetector(
        onTap: () {
          Modular.to.pushNamed(
            'diagnosisDetails',
            arguments: diagnose.sessionId,
          );
        },
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    diagnose.date != null
                        ? Formaters.dateToStringDate(
                            DateTime.fromMillisecondsSinceEpoch(
                              diagnose.date!.toInt(),
                            ),
                          )
                        : '-',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(child: SizedBox()),
                  const SizedBox(width: 15),
                  Text(
                    diagnose.date != null
                        ? Formaters.dateToStringTime(
                            DateTime.fromMillisecondsSinceEpoch(
                              diagnose.date!.toInt(),
                            ),
                          )
                        : '-',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '*',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          diagnose.reason ?? 'Não reconhecido',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        verifyUrgencyNull(context),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyUrgencyNull(BuildContext context) {
    if (diagnose.urgency != null) {
      return MediktorUrgencyWidget(urgency: diagnose.urgency!);
    } else {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          'Não há sugestão de diagnóstico',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }
  }
}
