import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/reimbursement_status_enum.dart';
import 'package:omni_plan/src/core/enums/reimbursement_type_enum.dart';
import 'package:omni_plan/src/core/models/reimbursements_results_model.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementItemWidget extends StatelessWidget {
  final ReimbursementModel model;
  const ReimbursementItemWidget({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(
          '/home/omniPlan/reimbursement/reimbursement_details',
          arguments: model.id,
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).cardColor.withOpacity(0.25),
          ),
        ),
        color: model.status == ReimbursementStatus.approved
            ? Colors.green.withOpacity(0.8)
            : model.status == ReimbursementStatus.denied
                ? Colors.red.withOpacity(0.8)
                : model.status == ReimbursementStatus.partial
                    ? Colors.blue
                    : Colors.amber.withOpacity(0.85),
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.status!.label,
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: model.status == ReimbursementStatus.approved
                            ? Colors.green.withOpacity(0.8)
                            : model.status == ReimbursementStatus.denied
                                ? Colors.red.withOpacity(0.8)
                                : model.status == ReimbursementStatus.partial
                                    ? Colors.blue
                                    : Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Data: ',
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Formaters.dateToStringDate(
                            Formaters.stringToDate(model.createdAt!),
                          ),
                          style: theme.textTheme.titleLarge!.copyWith(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          ReimbursementLabels.reimbursementItemProcedure,
                          style: theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          model.type!.label,
                          style: theme.textTheme.titleLarge!.copyWith(),
                        ),
                      ],
                    ),
                  ],
                ),
                SvgPicture.asset(
                  Assets.arrowRight,
                  package: AssetsPackage.omniGeneral,
                  color: Theme.of(context).primaryColor,
                  height: 15,
                  width: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
