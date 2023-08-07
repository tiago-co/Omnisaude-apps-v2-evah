import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_caregiver_item_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_caregiver_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_list_caregiver_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlCaregiverWidget extends StatefulWidget {
  final ScrollController scrollController;
  final String moduleName;

  const NewDrugControlCaregiverWidget({
    Key? key,
    required this.scrollController,
    required this.moduleName,
  }) : super(key: key);

  @override
  _NewDrugControlCaregiverWidgetState createState() =>
      _NewDrugControlCaregiverWidgetState();
}

class _NewDrugControlCaregiverWidgetState
    extends State<NewDrugControlCaregiverWidget>
    with SingleTickerProviderStateMixin {
  final NewDrugControlCaregiverStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final Duration duration = const Duration(milliseconds: 250);
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      animationController,
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCaregiverSwitchWidget,
        AnimatedBuilder(
          animation: animationController,
          builder: (_, child) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCaregiverListWidget,
                    const SizedBox(height: 10),
                    DefaultButtonWidget(
                      onPressed: () async {
                        Modular.to.pushNamed(
                          'newCaregiver',
                          arguments: widget.moduleName,
                        );
                      },
                      text:
                          DrugControlLabels.newDrugControlCaregiverNewCaregiver,
                      buttonType: DefaultButtonType.outline,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget get _buildCaregiverSwitchWidget {
    return TripleBuilder<NewDrugControlCaregiverStore, Exception, bool>(
      store: store,
      builder: (_, triple) {
        return Semantics(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: ListTile(
                    onTap: () {
                      if (animationController.isDismissed) {
                        animationController.forward();
                      } else {
                        animationController.reverse();
                      }
                      Future.delayed(const Duration(milliseconds: 300))
                          .then((value) {
                        widget.scrollController.animateTo(
                          widget.scrollController.position.maxScrollExtent,
                          duration: duration,
                          curve: Curves.decelerate,
                        );
                      });
                      store.updateState().catchError((onError) {
                        Helpers.showDialog(
                          context,
                          onError,
                          showClose: true,
                        );
                      });
                    },
                    minLeadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 7.5),
                      child: Text(
                        DrugControlLabels.newDrugControlCaregiverHaveCaregiver,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                    subtitle: Text(
                      DrugControlLabels.newDrugControlCaregiverDescription,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              CupertinoSwitch(
                value: triple.state,
                trackColor: Theme.of(context).cardColor.withOpacity(0.25),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool value) {
                  if (animationController.isDismissed) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }
                  store.updateState().catchError(
                    (onError) {
                      Helpers.showDialog(
                        context,
                        onError,
                        showClose: true,
                      );
                    },
                  );
                  Future.delayed(const Duration(milliseconds: 300))
                      .then((value) {
                    widget.scrollController.animateTo(
                      widget.scrollController.position.maxScrollExtent,
                      duration: duration,
                      curve: Curves.decelerate,
                    );
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get _buildCaregiverListWidget {
    return TripleBuilder<NewDrugControlListCaregiverStore, DioError,
        CaregiverResultsModel>(
      store: store.newDrugControlListCaregiverStore,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = Container(
            height: MediaQuery.of(context).size.height *
                0.083 *
                triple.state.results!.length,
            color: Colors.white.withOpacity(0.75),
            child: const LoadingWidget(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: InkWell(
                onTap: triple.isLoading
                    ? null
                    : () => store.newDrugControlListCaregiverStore
                            .getCaregivers(QueryParamsModel(limit: '100'))
                            .catchError((onError) {
                          Helpers.showDialog(
                            context,
                            onError,
                            showClose: true,
                          );
                        }),
                borderRadius: BorderRadius.circular(5),
                splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                highlightColor:
                    Theme.of(context).primaryColor.withOpacity(0.05),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DrugControlLabels.newDrugControlCaregiverPatch,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: triple.isLoading
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.50)
                                  : Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(width: 10),
                      ColoredBox(
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          Assets.refresh,
                          color: triple.isLoading
                              ? Theme.of(context).primaryColor.withOpacity(0.50)
                              : Theme.of(context).primaryColor,
                          package: AssetsPackage.omniGeneral,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                if (triple.state.results!.isEmpty && !triple.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child:
                          Text(DrugControlLabels.newDrugControlCaregiverEmpty),
                    ),
                  ),
                if (triple.state.results!.isNotEmpty)
                  ListView.separated(
                    itemCount: triple.state.results!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (_, index) {
                      return NewDrugControlCaregiverItemWidget(
                        caregiver: triple.state.results![index],
                      );
                    },
                  ),
                loading,
              ],
            ),
          ],
        );
      },
    );
  }
}
