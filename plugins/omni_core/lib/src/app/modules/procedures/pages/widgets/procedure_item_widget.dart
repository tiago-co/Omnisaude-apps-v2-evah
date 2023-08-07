import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_core/src/app/core/enums/procedure_enum.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/modules/procedures/pages/widgets/procedure_details_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:procedures_labels/labels.dart';

class ProcedureItemWidget extends StatelessWidget {
  final ProcedureModel procedure;

  const ProcedureItemWidget({
    Key? key,
    required this.procedure,
  }) : super(key: key);

  void showProcedureDetails(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    Helpers.showDialog(
      context,
      ProcedureDetailsWidget(
        procedure: procedure,
        callback: () => showProcedureDetails(context),
      ),
      showClose: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return VerticalTimelineItemWidget(
      child: GestureDetector(
        onTap: () => showProcedureDetails(context),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('dd/MM').format(
                      Formaters.stringToDateTime(procedure.date!),
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
                      children: [_buildProcedureStatus(context)],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    DateFormat('Hm').format(
                      Formaters.stringToDateTime(procedure.date!),
                    ),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  procedure.name ?? ProceduresLabels.procedureItemNoName,
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
                      procedure.hospitalName ??
                          ProceduresLabels.procedureItemNoHospitalName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                          ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    procedure.type!.label,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcedureStatus(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: procedure.status!.color?.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
      child: Text(
        procedure.status?.label ?? ProceduresLabels.procedureItemNoStatus,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: procedure.status!.color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
      ),
    );
  }
}
