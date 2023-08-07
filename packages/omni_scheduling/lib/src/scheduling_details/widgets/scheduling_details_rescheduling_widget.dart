import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsReschedulingWidget extends StatelessWidget {
  final SchedulingDetailsStore store = Modular.get();
  final SchedulingModel scheduling;
  final String beneficiaryId;

  SchedulingDetailsReschedulingWidget({
    Key? key,
    required this.scheduling,
    required this.beneficiaryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scheduling.oldScheduling?.createdBy == beneficiaryId ||
        scheduling.oldScheduling?.reschedulingBy == beneficiaryId ||
        scheduling.createdBy == beneficiaryId) return Container();

    String message =
        SchedulingLabels.schedulingDetailsReschedulingProfessionalRescheduling;
    if (scheduling.createdBy != beneficiaryId &&
        scheduling.oldScheduling == null) {
      message = SchedulingLabels
          .schedulingDetailsReschedulingProfessionalNewScheduling;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () {
                    store.updateSchedulingById(
                      scheduling.id!,
                      {'acao': 'reprovar'},
                    ).then((value) => store.getSchedulingById(store.state.id!));
                  },
                  buttonType: DefaultButtonType.outline,
                  text: SchedulingLabels.schedulingDetailsReschedulingRefuse,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () {
                    store.updateSchedulingById(
                      scheduling.id!,
                      {'acao': 'aprovar'},
                    ).then((value) => store.getSchedulingById(store.state.id!));
                  },
                  text: SchedulingLabels.schedulingDetailsReschedulingAccept,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
