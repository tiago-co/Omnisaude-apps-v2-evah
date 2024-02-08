import 'package:dio/dio.dart';
import 'package:drawer_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/drawer/widgets/add_program_widget.dart';
import 'package:omni_core/src/app/modules/drawer/widgets/inactivate_program_widget.dart';
import 'package:omni_general/omni_general.dart';

class ChooseProgramWidget extends StatefulWidget {
  final VoidCallback callback;

  const ChooseProgramWidget({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  _ChooseProgramWidgetState createState() => _ChooseProgramWidgetState();
}

class _ChooseProgramWidgetState extends State<ChooseProgramWidget> {
  final TextEditingController textController = TextEditingController();
  final ProgramStore programStore = Modular.get();

  @override
  void initState() {
    programStore.getPrograms().catchError((onError) => null);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                bottom:
                    MediaQuery.of(context).viewInsets.bottom >= 60 ? MediaQuery.of(context).viewInsets.bottom - 60 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BottomSheetHeaderWidget(
                    showSearch: true,
                    controller: textController,
                    title: DrawerLabels.chooseProgramSearchTitle,
                    onSearch: programStore.getProgramParams,
                    searchPlaceholder: DrawerLabels.chooseProgramSearchPlaceholder,
                  ),
                  Flexible(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        shadowColor: Colors.transparent,
                      ),
                      child: RefreshIndicator(
                        displacement: 0,
                        strokeWidth: 0.75,
                        color: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).colorScheme.background,
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        onRefresh: () async {
                          programStore.getPrograms().catchError(
                                (onError) => null,
                              );
                        },
                        child: _buildProgramListWidget,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          TripleBuilder(
            store: programStore,
            builder: (_, triple) {
              return BottomButtonWidget(
                onPressed: () async {
                  Modular.to.pop();
                  await showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (_) => const AddProgramWidget(),
                  ).whenComplete(() => widget.callback());
                },
                isLoading: triple.isLoading,
                buttonType: BottomButtonType.outline,
                text: DrawerLabels.chooseProgramNewProgram,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _buildProgramListWidget {
    return TripleBuilder<ProgramStore, DioError, List<ProgramModel>>(
      store: programStore,
      builder: (_, triple) {
        if (triple.event == TripleEvent.error) {
          return RequestErrorWidget(
            error: triple.error,
            onPressed: () => programStore.getPrograms(),
          );
        }

        if (programStore.state.isEmpty && triple.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const LoadingWidget(),
                const SizedBox(height: 15),
                Text(
                  DrawerLabels.chooseProgramSearching,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          );
        }

        if (programStore.state.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: EmptyWidget(message: DrawerLabels.chooseProgramEmpty),
          );
        }
        return AbsorbPointer(
          absorbing: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: ListView.separated(
              separatorBuilder: (_, index) {
                return const Divider();
              },
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              itemCount: programStore.state.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                // return _buildProgramItemWidget(programStore.state[index]);
              },
            ),
          ),
        );
      },
    );
  }

  // Widget _buildProgramItemWidget(ProgramModel program) {
  //   final bool selected = program.id == programStore.programSelected.id;
  //   final bool active = program.statusPsp == StatusType.active &&
  //       program.status == StatusType.active;
  //   final Color color = Color(
  //     int.parse('0xFF${program.enterprise!.primaryColor}'),
  //   );

  //   return Opacity(
  //     opacity: active ? 1.0 : 0.25,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: color.withOpacity(selected ? 1.0 : 0.01),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 10),
  //       child: ListTile(
  //         dense: false,
  //         onTap: !active
  //             ? null
  //             : () {
  //                 if (selected) return;
  //                 programStore.changeProgramSelected(program.id!).then((value) {
  //                   setState(() {});
  //                 }).catchError((onError) {
  //                   Helpers.showDialog(
  //                     context,
  //                     RequestErrorWidget(
  //                       error: onError,
  //                       buttonText: DrawerLabels.close,
  //                       onPressed: () => Modular.to.pop(),
  //                     ),
  //                     showClose: true,
  //                   );
  //                 });
  //               },
  //         title: Row(
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 program.name!,
  //                 style: Theme.of(context).textTheme.headlineSmall!.copyWith(
  //                       color: selected ? Colors.white : null,
  //                       fontWeight: selected ? FontWeight.w600 : null,
  //                     ),
  //               ),
  //             ),
  //             if (programStore.canLeftProgram && selected && active)
  //               const SizedBox(width: 10),
  //             if (programStore.canLeftProgram && selected && active)
  //               GestureDetector(
  //                 onTap: () async {
  //                   Modular.to.pop();
  //                   await showModalBottomSheet(
  //                     context: context,
  //                     enableDrag: true,
  //                     isScrollControlled: true,
  //                     backgroundColor: Theme.of(context).colorScheme.background,
  //                     shape: const RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(10),
  //                         topRight: Radius.circular(10),
  //                       ),
  //                     ),
  //                     builder: (_) => const InactivateProgramWidget(),
  //                   ).whenComplete(() => widget.callback());
  //                 },
  //                 child: Tooltip(
  //                   message: DrawerLabels.chooseProgramInactive,
  //                   margin: const EdgeInsets.symmetric(horizontal: 5),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.white.withOpacity(0.75),
  //                       borderRadius: BorderRadius.circular(5),
  //                     ),
  //                     padding: const EdgeInsets.all(5),
  //                     child: SvgPicture.asset(
  //                       Assets.exit,
  //                       package: AssetsPackage.omniGeneral,
  //                       color: color,
  //                       width: 25,
  //                       height: 25,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //         contentPadding: EdgeInsets.zero,
  //         leading: program.enterprise!.logo != null
  //             ? AbsorbPointer(
  //                 child: ImageWidget(
  //                   url: program.enterprise!.logo!,
  //                   width: 40,
  //                   height: 30,
  //                 ),
  //               )
  //             : Icon(
  //                 Icons.business_rounded,
  //                 color: selected
  //                     ? Theme.of(context).colorScheme.background
  //                     : color,
  //               ),
  //         minLeadingWidth: 0,
  //         trailing: SvgPicture.asset(
  //           Assets.arrowRight,
  //           color: selected
  //               ? Theme.of(context).colorScheme.background
  //               : color.withOpacity(0.5),
  //           package: AssetsPackage.omniGeneral,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
