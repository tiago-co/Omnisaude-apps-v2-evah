import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementStepsWidget extends StatelessWidget {
  final int step;
  final PageController controller;
  ReimbursementStepsWidget({
    Key? key,
    required this.step,
    required this.controller,
  }) : super(key: key);

  final ReimbursementStepStore reimbursementStepStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          if (step == 0)
            Text(
              ReimbursementLabels.reimbursementStepsPersonalData,
              style: textStyle,
            ),
          if (step == 1)
            Text(
              ReimbursementLabels.reimbursementStepsAttendenceType,
              style: textStyle,
            ),
          if (step == 2)
            Text(
              ReimbursementLabels.reimbursementStepsDocumentList,
              style: textStyle,
            ),
          if (step == 3)
            Text(
              ReimbursementLabels.reimbursementStepsRepaymentTerm,
              style: textStyle,
            ),
          if (step == 4)
            Text(
              ReimbursementLabels.reimbursementStepsRequestResume,
              style: textStyle,
            ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: step > 0
                      ? () async {
                          await controller.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                          reimbursementStepStore
                              .updateStep(controller.page!.round());
                        }
                      : null,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: step == 0
                          ? Border.all(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                      color: step == 0
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: step >= 1
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: step > 1
                      ? () async {
                          await controller.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                          reimbursementStepStore
                              .updateStep(controller.page!.round());
                        }
                      : null,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: step == 1
                          ? Border.all(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                      color: step > 1
                          ? Theme.of(context).primaryColor
                          : step == 1
                              ? Colors.white
                              : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: step >= 2
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: step > 2
                      ? () async {
                          await controller.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                          reimbursementStepStore
                              .updateStep(controller.page!.round());
                        }
                      : null,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: step == 2
                          ? Border.all(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                      color: step > 2
                          ? Theme.of(context).primaryColor
                          : step == 2
                              ? Colors.white
                              : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: step >= 3
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: step > 3
                      ? () async {
                          await controller.animateToPage(
                            3,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                          reimbursementStepStore
                              .updateStep(controller.page!.round());
                        }
                      : null,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: step == 3
                          ? Border.all(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                      color: step > 3
                          ? Theme.of(context).primaryColor
                          : step == 3
                              ? Colors.white
                              : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: step >= 4
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor.withOpacity(0.2),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: step == 4
                        ? Border.all(
                            width: 3,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                    color: step > 4
                        ? Theme.of(context).primaryColor
                        : step == 4
                            ? Colors.white
                            : Theme.of(context).cardColor.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
