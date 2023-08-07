import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_token_model.dart';

import 'package:omni_plan/src/modules/plan_card/stores/plan_card_store.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_modules_store.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_token_store.dart';
import 'package:omni_plan/src/modules/plan_card/widgets/card_back_widget.dart';
import 'package:omni_plan/src/modules/plan_card/widgets/card_front_widget.dart';
import 'package:omni_plan/src/modules/plan_card/widgets/plan_list_item_shimmer.dart';
import 'package:omni_plan/src/modules/plan_card/widgets/plan_menu_item.dart';
import 'package:omni_plan/src/modules/plan_card/widgets/plan_token_widget.dart';
import 'package:plan_card_labels/labels.dart';

class PlanCardPage extends StatefulWidget {
  final String moduleName;
  const PlanCardPage({Key? key, required this.moduleName}) : super(key: key);

  @override
  _PlanCardPageState createState() => _PlanCardPageState();
}

class _PlanCardPageState extends State<PlanCardPage> {
  final PlanCardStore store = Modular.get();
  final PlanModulesStore planModulesStore = Modular.get();
  final PlanTokenStore tokenStore = Modular.get();
  final UserStore userStore = Modular.get();

  @override
  void initState() {
    store.getPlanCard();
    planModulesStore.getPlanModules();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(title: PlanCardLabels.planCardTitle)
          .build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ExpansionTile(
                initiallyExpanded:
                    userStore.state.beneficiary!.isPlanCardExpansive!,
                onExpansionChanged: (value) async {
                  userStore.state.beneficiary!.isPlanCardExpansive = value;
                  await userStore.setUserPreferences(
                    userStore.state,
                    userStore.state.jwt!.id!,
                  );
                  setState(() {
                    
                  });
                },
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor.withOpacity(0.025),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    Assets.planCardBase,
                    package: AssetsPackage.omniGeneral,
                    color: Theme.of(context).cardColor,
                    width: 27,
                    height: 27,
                  ),
                ),
                title: Text(
                  PlanCardLabels.cardInfoMyCard,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                trailing: Transform.rotate(
                  angle: userStore.state.beneficiary!.isPlanCardExpansive!
                      ? (90 * 3.14 / 180) * -1
                      : (90 * 3.14 / 180),
                  child: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    size: 30,
                  ),
                ),
                children: [
                  CarouselSlider(
                    items: const [
                      CardFrontWidget(),
                      CardBackWidget(),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 0.90,
                      height: 230,
                      enableInfiniteScroll: false,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child:
                  TripleBuilder<PlanModulesStore, DioError, List<ModuleModel>>(
                store: planModulesStore,
                builder: (_, triple) {
                  if (triple.isLoading) {
                    return const PlanListItemShimmer();
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      await planModulesStore.getPlanModules();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          generateTokenTileWidget,
                          const Divider(),
                          ListView.separated(
                            itemCount: planModulesStore.state.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              if (planModulesStore.state[index].type
                                      .moduleTypeOnTap(
                                    planModulesStore.state[index].type,
                                    planModulesStore.state[index].name ??
                                        planModulesStore.state[index].type.name(
                                          planModulesStore.state[index].type,
                                        ),
                                  ) ==
                                  null) {
                                return Container();
                              }
                              return PlanMenuItem(
                                title: planModulesStore.state[index].name!,
                                asset: planModulesStore.state[index].type.asset(
                                  planModulesStore.state[index].type,
                                ),
                                assetBase: planModulesStore.state[index].type
                                    .assetBase(
                                  planModulesStore.state[index].type,
                                ),
                                package: AssetsPackage.omniGeneral,
                                onTap: planModulesStore.state[index].type
                                    .moduleTypeOnTap(
                                  planModulesStore.state[index].type,
                                  planModulesStore.state[index].name ??
                                      planModulesStore.state[index].type.name(
                                        planModulesStore.state[index].type,
                                      ),
                                ),
                              );
                            },
                            separatorBuilder: (_, index) => const Divider(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get generateTokenTileWidget {
    return TripleBuilder<PlanModulesStore, DioError, List<ModuleModel>>(
      store: planModulesStore,
      builder: (_, triple) {
        return Visibility(
          visible: !triple.isLoading,
          child: Builder(
            builder: (context) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                child: PlanMenuItem(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    enableDrag: false,
                    isScrollControlled: false,
                    builder: (_) =>
                        TripleBuilder<PlanTokenStore, DioError, PlanTokenModel>(
                      store: tokenStore,
                      builder: (_, triple) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => Modular.to.pop(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        15.0,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: SvgPicture.asset(
                                          Assets.close,
                                          package: AssetsPackage.omniGeneral,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 45,
                                  right: 30,
                                  left: 20,
                                ),
                                child: PlanTokenWidget(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  title: PlanCardLabels.planCardGenerateToken,
                  asset: Assets.tokenTwo,
                  assetBase: Assets.tokenOne,
                  package: AssetsPackage.omniGeneral,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
