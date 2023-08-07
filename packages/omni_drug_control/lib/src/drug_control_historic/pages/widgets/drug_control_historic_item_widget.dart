import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_drug_control/src/core/constants/drug_control_interval.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart' show Formaters;

class DrugControlHistoricItemWidget extends StatelessWidget {
  final DrugControlModel drugControl;
  const DrugControlHistoricItemWidget({
    Key? key,
    required this.drugControl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('drugControlDetails', arguments: drugControl);
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  Formaters.dateToStringDate(
                    Formaters.stringToDateTime(drugControl.startDate!),
                  ),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(width: 15),
                const Expanded(child: SizedBox()),
                const SizedBox(width: 15),
                Text(
                  Formaters.dateToStringTime(
                    Formaters.stringToDateTime(drugControl.startDate!),
                  ),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).cardColor,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      drugControl.medicine ??
                          DrugControlLabels.drugControlHistoricNoName,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Text(
                '${drugControl.dosage ?? '-'} '
                '${drugControl.unity ?? '-'} '
                '${drugControl.administration ?? '-'} | '
                '${DRUG_CONTROL_INTERVALS[drugControl.interval] ?? '-'}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
