import 'package:drawer_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/modules/drawer/widgets/choose_program_widget.dart';
import 'package:omni_general/omni_general.dart';

class ProgramActiveWidget extends StatefulWidget {
  const ProgramActiveWidget({Key? key}) : super(key: key);

  @override
  _ProgramActiveWidgetState createState() => _ProgramActiveWidgetState();
}

class _ProgramActiveWidgetState extends State<ProgramActiveWidget> {
  final ProgramStore programStore = Modular.get();

  Future<void> chooseProgramSheetCallback() async {
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChooseProgramWidget(callback: chooseProgramSheetCallback),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 5),
          Text(
            DrawerLabels.programActiveTitle,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 5),
          // ScopedBuilder(
          //   store: programStore,
          //   onState: (_, state) {
          //     return InkWell(
          //       onTap: programStore.canChangeProgram
          //           ? chooseProgramSheetCallback
          //           : null,
          //       borderRadius: BorderRadius.circular(10),
          //       highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          //       splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
          //       child: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Theme.of(context).cardColor.withOpacity(0.025),
          //         ),
          //         padding: const EdgeInsets.all(10),
          //         child: _buildProgramWidget(programStore.programSelected),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildProgramWidget(ProgramModel program) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: ColoredBox(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            child: program.enterprise!.logo != null
                ? AbsorbPointer(
                    child: ImageWidget(
                      url: program.enterprise!.logo!,
                      width: 40,
                      height: 30,
                    ),
                  )
                : Icon(
                    Icons.business_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            program.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
          ),
        ),
        // if (programStore.canChangeProgram)
        Icon(Icons.edit, color: Theme.of(context).primaryColor),
      ],
    );
  }
}
