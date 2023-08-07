import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_program_disease_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlProgramDiseaseWidget extends StatefulWidget {
  final ProgramModel program;

  const NewDrugControlProgramDiseaseWidget({
    Key? key,
    required this.program,
  }) : super(key: key);

  @override
  _NewDrugControlProgramDiseaseStateWidget createState() =>
      _NewDrugControlProgramDiseaseStateWidget();
}

class _NewDrugControlProgramDiseaseStateWidget
    extends State<NewDrugControlProgramDiseaseWidget> {
  final NewDrugControlProgramDiseaseStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    if (widget.program.disease == null) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -5,
            color: Theme.of(context).cardColor,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: TripleBuilder<NewDrugControlProgramDiseaseStore, Exception, bool>(
        store: store,
        builder: (_, triple) {
          return _buildSwitchWidget(triple.state);
        },
      ),
    );
  }

  Widget _buildSwitchWidget(bool active) {
    return Semantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                highlightColor: Colors.transparent,
              ),
              child: ListTile(
                leading: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.programDisease,
                      package: AssetsPackage.omniDrugControl,
                    ),
                  ],
                ),
                minLeadingWidth: 0,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 7.5),
                  child: Text(
                    DrugControlLabels.newDrugControlProgramDiseaseIsPart,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                visualDensity: VisualDensity.compact,
                enableFeedback: true,
                subtitle: Text(
                  '${widget.program.disease!.code!} - '
                  '${widget.program.disease!.name}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                      ),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          CupertinoSwitch(
            value: active,
            trackColor: Theme.of(context).cardColor.withOpacity(0.25),
            activeColor: Theme.of(context).primaryColor,
            onChanged: store.onChangeCheckBoxValue,
          ),
        ],
      ),
    );
  }
}
