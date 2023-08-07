import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_status_enum.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_beneficiary_store.dart';

import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_cancel_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_change_date_widget.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsActionsWidget extends StatelessWidget {
  final SchedulingModel scheduling;
  final SchedulingDetailsBeneficiaryStore beneficiaryStore = Modular.get();

  SchedulingDetailsActionsWidget({
    Key? key,
    required this.scheduling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: GridView(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          _buildActionItemWidget(
            context,
            scheduling.status == SchedulingStatus.inService
                ? SchedulingLabels.schedulingDetailsActionsStartAttendance
                : scheduling.status == SchedulingStatus.attended
                    ? SchedulingLabels.schedulingDetailsActionsMyAttendance
                    : SchedulingLabels.schedulingDetailsActionsMyAppointment,
            () {
              beneficiaryStore.setBeneficiaryIntoStatus(scheduling);
              Modular.to.pushNamed('chatAppointment', arguments: scheduling);
            },
            Assets.appointment,
            Assets.appointmentBase,
            isActive: (scheduling.status == SchedulingStatus.inService &&
                    scheduling.type == SchedulingType.teleAttendance) ||
                scheduling.status == SchedulingStatus.attended,
          ),
          _buildActionItemWidget(
            context,
            SchedulingLabels.schedulingDetailsActionsMedicalRecord,
            () => Modular.to.pushNamed(
              'medicalRecords',
              arguments: scheduling.appointment,
            ),
            Assets.medicalRecords,
            Assets.medicalRecordsBase,
            isActive: scheduling.status == SchedulingStatus.attended &&
                scheduling.appointment != null,
          ),
          _buildActionItemWidget(
            context,
            SchedulingLabels.schedulingDetailsActionsCertificate,
            () => Modular.to.pushNamed(
              'medicalCertificate',
              arguments: scheduling.medicalCertificate!.code,
            ),
            Assets.medicalCertificate,
            Assets.medicalCertificateBase,
            isActive: scheduling.status == SchedulingStatus.attended &&
                scheduling.medicalCertificate != null,
          ),
          _buildActionItemWidget(
            context,
            SchedulingLabels.schedulingDetailsActionsPrescription,
            () => Modular.to.pushNamed(
              'prescription',
              arguments: scheduling.appointment!.id,
            ),
            Assets.medicalPrescription,
            Assets.medicalPrescriptionBase,
            isActive: scheduling.appointment != null &&
                scheduling.status == SchedulingStatus.attended &&
                scheduling.medicalPrescription == true,
          ),
          _buildActionItemWidget(
            context,
            SchedulingLabels.schedulingDetailsActionsLaboratoryTests,
            () => Modular.to.pushNamed(
              'hilabExams',
              arguments: scheduling.hilabExams,
            ),
            Assets.report,
            Assets.reportBase,
            isActive: scheduling.hilabExams?.isNotEmpty ?? false,
          ),
          _buildActionItemWidget(
            context,
            SchedulingLabels.schedulingDetailsActionsRescheduleAppointment,
            () async {
              await showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                builder: (_) => SchedulingDetailsChangeDateWidget(
                  scheduling: scheduling,
                ),
              );
            },
            Assets.rescheduling,
            Assets.reschedulingBase,
            isActive: scheduling.status == SchedulingStatus.approved ||
                scheduling.status == SchedulingStatus.onApproval,
          ),
          _buildActionItemWidget(
            context,
            SchedulingLabels.schedulingDetailsActionsCancelAppointment,
            () async {
              await showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                builder: (_) => SchedulingDetailsCancelWidget(
                  schedulingId: scheduling.id!,
                ),
              );
            },
            Assets.schedulingCancel,
            Assets.schedulingCancelBase,
            isActive: scheduling.status == SchedulingStatus.approved ||
                scheduling.status == SchedulingStatus.onApproval,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItemWidget(
    BuildContext context,
    String label,
    Function onTap,
    String asset,
    String assetBase, {
    bool isActive = false,
    String? package,
  }) {
    return Tooltip(
      message: label,
      child: AbsorbPointer(
        absorbing: !isActive,
        child: Opacity(
          opacity: isActive ? 1.0 : 0.25,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor.withOpacity(0.05),
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.3,
              minHeight: MediaQuery.of(context).size.width * 0.3,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => onTap.call(),
                borderRadius: BorderRadius.circular(10),
                highlightColor: Colors.transparent,
                splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          _buildAssetBanner(
                            context,
                            asset,
                            assetBase,
                            package ?? AssetsPackage.omniScheduling,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 40,
                            child: SvgPicture.asset(
                              Assets.baseModule,
                              color: Theme.of(context).cardColor.withOpacity(
                                    0.5,
                                  ),
                              package: AssetsPackage.omniGeneral,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    height: 1,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssetBanner(
    BuildContext context,
    String asset,
    String assetBase,
    String package,
  ) {
    return Stack(
      children: [
        SvgPicture.asset(
          assetBase,
          width: 50,
          height: 50,
          color: Theme.of(context).cardColor,
          package: package,
        ),
        SvgPicture.asset(
          asset,
          width: 50,
          height: 50,
          color: Theme.of(context).primaryColor,
          package: package,
        ),
      ],
    );
  }
}
