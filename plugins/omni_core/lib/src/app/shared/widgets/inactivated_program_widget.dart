import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class ProgramInactivateWidget extends StatefulWidget {
  final StatusType status;
  final Function refreshModules;

  const ProgramInactivateWidget({
    Key? key,
    required this.status,
    required this.refreshModules,
  }) : super(key: key);

  @override
  _ProgramInactivateWidgetState createState() => _ProgramInactivateWidgetState();
}

class _ProgramInactivateWidgetState extends State<ProgramInactivateWidget> {
  final ProgramStore store = Modular.get();
  String? text;

  @override
  void initState() {
    // final String name = store.programSelected.name ?? '';
    // text =
    //     '${SharedLabels.inactivatedProgramProgram} ${Formaters.capitalize(name)} ${SharedLabels.inactivatedProgramIsInactive}';
    // if (widget.status == StatusType.inactive) {
    //   text =
    //       '${SharedLabels.inactivatedProgramEjected} ${Formaters.capitalize(name)}';
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: TripleBuilder(
          store: store,
          builder: (_, triple) {
            return EmptyWidget(
              message: '$text.\n ${SharedLabels.inactivatedProgramEnterInContact}',
              isDisabled: triple.isLoading,
              onPressed: () => widget.refreshModules(),
              textButton: SharedLabels.inactivatedProgramUpdate,
            );
          },
        ),
      ),
    );
  }
}
