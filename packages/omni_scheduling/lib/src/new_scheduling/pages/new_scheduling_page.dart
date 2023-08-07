import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_mode_enum.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';
import 'package:omni_scheduling/src/core/models/scheduling_mode_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/new_scheduling_success_page.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/scheduling_category_page.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/scheduling_observation_page.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/scheduling_professional_page.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/scheduling_bottom_button_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class NewSchedulingPage extends StatefulWidget {
  final String moduleName;
  final String beneficiaryId;
  final SchedulingType schedulingType;
  final SchedulingModeModel? schedulingMode;
  const NewSchedulingPage({
    Key? key,
    required this.moduleName,
    required this.beneficiaryId,
    required this.schedulingType,
    this.schedulingMode,
  }) : super(key: key);

  @override
  _NewSchedulingPageState createState() => _NewSchedulingPageState();
}

class _NewSchedulingPageState extends State<NewSchedulingPage> {
  final NewSchedulingStore store = Modular.get();
  final PageController pageController = PageController();
  final SchedulingBottomButtonStore buttonStore = Modular.get();
  final SchedulingHistoricStore schedulingHistoricStore = Modular.get();

  @override
  void initState() {
    store.params.ordering = 'true';
    store.params.type = '';
    store.state.schedulingType = widget.schedulingType;
    store.state.beneficiaryId = widget.beneficiaryId;
    super.initState();
  }

  void typePageNext(
    NewSchedulingModel newSchedulingModel,
    SchedulingType schedulingType,
  ) {
    if (store.categoryStep == 0) {
      store.onChangeSchedulingType(schedulingType);
      store.updateForm(store.state);
      store.updateForm(NewSchedulingModel.fromJson(store.state.toJson()));
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
      store.categoryStep = pageController.page!.round();
    }
  }

  List<Widget> getPageList(PageController pageController) {
    if (widget.schedulingMode!.schedulingModeType ==
        SchedulingModeType.mediktor) {
      return <Widget>[
        SchedulingProfessionalPage(
          pageController: pageController,
          mediktorId: widget.schedulingMode!.mediktorId,
          schedulingModeType: widget.schedulingMode!.schedulingModeType!,
        ),
        TripleBuilder<NewSchedulingStore, Exception, NewSchedulingModel>(
          store: store,
          builder: (_, triple) {
            return Opacity(
              opacity: triple.isLoading ? 0.75 : 1.0,
              child: IgnorePointer(
                ignoring: triple.isLoading,
                child: SchedulingObservationPage(
                  pageController: pageController,
                  schedulingModeType:
                      widget.schedulingMode!.schedulingModeType!,
                ),
              ),
            );
          },
        ),
        const NewSchedulingSuccessPage(),
      ];
    } else {
      return <Widget>[
        SchedulingCategoryPage(
          pageController: pageController,
          schedulingModeType: widget.schedulingMode!.schedulingModeType!,
          schedulingType: widget.schedulingType,
        ),
        SchedulingProfessionalPage(
          pageController: pageController,
          schedulingModeType: widget.schedulingMode!.schedulingModeType!,
        ),
        TripleBuilder<NewSchedulingStore, Exception, NewSchedulingModel>(
          store: store,
          builder: (_, triple) {
            return Opacity(
              opacity: triple.isLoading ? 0.75 : 1.0,
              child: IgnorePointer(
                ignoring: triple.isLoading,
                child: SchedulingObservationPage(
                  pageController: pageController,
                  schedulingModeType:
                      widget.schedulingMode!.schedulingModeType!,
                ),
              ),
            );
          },
        ),
        const NewSchedulingSuccessPage(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (int value) {
            store.categoryStep = value;
            store.updateForm(store.state);
          },
          children: getPageList(pageController),
        ),
      ),
      bottomNavigationBar:
          ScopedBuilder<SchedulingBottomButtonStore, Exception, bool>(
        store: buttonStore,
        onState: (_, scoped) {
          if (buttonStore.state) {
            return _buildSchedulingBottomButtomWidget;
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget get _buildSchedulingBottomButtomWidget {
    return TripleBuilder<NewSchedulingStore, Exception, NewSchedulingModel>(
      store: store,
      builder: (_, triple) {
        return BottomButtonWidget(
          onPressed: widget.schedulingMode!.schedulingModeType !=
                  SchedulingModeType.mediktor
              ? () {
                  if (store.categoryStep == 2) {
                    log(store.categoryStep.toString());

                    store.createScheduling(triple.state).then((value) async {
                      final DateTime now = DateTime.now();
                      final SchedulingParamsModel params =
                          SchedulingParamsModel(
                        startDate: Formaters.dateToStringDate(
                          DateTime(now.year, now.month),
                        ),
                        endDate: Formaters.dateToStringDate(
                          DateTime(now.year, now.month + 1, 0),
                        ),
                      );
                      await schedulingHistoricStore
                          .getSchedules(schedulingHistoricStore.params);
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    }).catchError((onError) {
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          error: onError,
                          onPressed: () => Modular.to.pop(),
                          buttonText: SchedulingLabels.close,
                        ),
                        showClose: true,
                      );
                    });
                  } else if (store.categoryStep == 3) {
                    log(store.categoryStep.toString());
                    Modular.to.pushReplacementNamed(
                      '../schedulingDetails',
                      arguments: {
                        'attendanceType': triple.state.schedulingType!.label,
                        'schedulingId': triple.state.id,
                        'beneficiaryId': widget.beneficiaryId,
                      },
                    );
                  } else {
                    log(store.categoryStep.toString());

                    pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                    );
                    store.categoryStep = pageController.page!.round();
                    store.updateForm(store.state);
                  }
                }
              : () {
                  if (store.categoryStep == 1) {
                    store.createScheduling(triple.state).then((value) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    }).catchError((onError) {
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          error: onError,
                          onPressed: () => Modular.to.pop(),
                          buttonText: SchedulingLabels.close,
                        ),
                        showClose: true,
                      );
                    });
                  } else if (store.categoryStep == 2) {
                    Modular.to.pushNamed(
                      '../schedulingDetails',
                      arguments: {
                        'attendanceType': triple.state.schedulingType!.label,
                        'schedulingId': triple.state.id,
                        'beneficiaryId': widget.beneficiaryId,
                      },
                    );
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                    );
                    store.categoryStep = pageController.page!.round();
                    store.updateForm(store.state);
                  }
                },
          isLoading: triple.isLoading,
          buttonType: BottomButtonType.outline,
          isDisabled: widget.schedulingMode!.schedulingModeType !=
                  SchedulingModeType.mediktor
              ? store.isSimpleButtonDisabled(
                  store.categoryStep,
                  triple.state,
                )
              : store.isMediktorButtonDisabled(
                  store.categoryStep,
                  triple.state,
                ),
          text: widget.schedulingMode!.schedulingModeType !=
                  SchedulingModeType.mediktor
              ? store.categoryStep == 2
                  ? SchedulingLabels.newSchedulingSchedule
                  : store.categoryStep == 3
                      ? SchedulingLabels.newSchedulingSeeSchedule
                      : SchedulingLabels.continueLabel
              : store.categoryStep == 1
                  ? SchedulingLabels.newSchedulingSchedule
                  : store.categoryStep == 2
                      ? SchedulingLabels.newSchedulingSeeSchedule
                      : SchedulingLabels.continueLabel,
        );
      },
    );
  }
}
