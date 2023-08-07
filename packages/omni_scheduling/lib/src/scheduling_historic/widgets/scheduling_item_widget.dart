import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_status_enum.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingItemWidget extends StatelessWidget {
  final SchedulingHistoricStore store = Modular.get();
  final SchedulingModel scheduling;
  final String beneficiaryId;
  final String? typeScheduling;

  SchedulingItemWidget({
    Key? key,
    required this.scheduling,
    required this.beneficiaryId,
    this.typeScheduling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalTimelineItemWidget(
      child: GestureDetector(
        onTap: () {
          log('SchedulingItemWidget');
          Modular.to.pushNamed(
            'schedulingDetails',
            arguments: {
              'attendanceType': typeScheduling ?? scheduling.type?.label,
              'schedulingId': scheduling.id,
              'beneficiaryId': beneficiaryId,
            },
          ).then((scheduling) {
            if (scheduling == null) return;
            store.updateScheduling(scheduling as SchedulingModel);
          });
        },
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('dd/MM').format(
                      Formaters.stringToDateTime(scheduling.startDate!),
                    ),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_buildSchedulingStatus(context)],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    DateFormat('Hm').format(
                      Formaters.stringToDateTime(scheduling.startDate!),
                    ),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  scheduling.professional?.name ??
                      SchedulingLabels
                          .schedulingItemProfessionalNamePlaceholder,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      scheduling.specialty?.name ??
                          SchedulingLabels.schedulingItemSpecialtyPlaceholder,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                          ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  if (scheduling.haveHilabExams != null &&
                      scheduling.haveHilabExams == true)
                    Column(
                      children: [
                        SvgPicture.asset(
                          Assets.haveExam,
                          package: AssetsPackage.omniScheduling,
                          color: Theme.of(context).primaryColor,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                  if (scheduling.type == SchedulingType.presential)
                    SvgPicture.asset(
                      Assets.presential,
                      package: AssetsPackage.omniScheduling,
                      color: Theme.of(context).primaryColor,
                      width: 20,
                      height: 20,
                    ),
                  if (scheduling.type == SchedulingType.teleAttendance)
                    SvgPicture.asset(
                      Assets.teleattendance,
                      package: AssetsPackage.omniScheduling,
                      color: Theme.of(context).primaryColor,
                      width: 20,
                      height: 20,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchedulingStatus(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: scheduling.status!.color.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
      child: Text(
        scheduling.status?.label ??
            SchedulingLabels.schedulingItemStatusPlaceholder,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: scheduling.status!.color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
      ),
    );
  }
}
