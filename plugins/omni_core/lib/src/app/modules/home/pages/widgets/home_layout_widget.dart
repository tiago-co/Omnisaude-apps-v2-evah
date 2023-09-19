import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:home_labels/labels.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/home_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/omniplan_module_icon_store.dart';
import 'package:omni_core/src/app/modules/home/pages/widgets/home_modules_group_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/home/pages/widgets/home_modules_group_widget.dart';
import 'package:omni_core/src/app/shared/widgets/inactivated_program_widget.dart';
import 'package:omni_core/src/app/shared/widgets/module_banner/grid_module_item_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/module_banner/grid_module_item_widget.dart';
import 'package:omni_core/src/app/shared/widgets/module_banner/list_module_item_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/module_banner/list_module_item_widget.dart';
import 'package:omni_general/omni_general.dart';

class HomeLayoutWidget extends StatefulWidget {
  const HomeLayoutWidget({Key? key}) : super(key: key);

  @override
  State<HomeLayoutWidget> createState() => _HomeLayoutWidgetState();
}

class _HomeLayoutWidgetState extends State<HomeLayoutWidget> {
  final HomeStore store = Modular.get();
  final ScrollController scrollController = ScrollController();
  final OmniplanModuleIconStore omniplanModuleIconStore = Modular.get();

  Future<void> refreshModules() async {
    store.userStore.getBeneficiaryById(store.userStore.userId);
    await store.modulesStore.getActiveModules().then((value) {
      omniplanModuleIconStore.getOmniPlanModuleStatus();
    }).catchError((onError) {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(shadowColor: Colors.transparent),
      child: RefreshIndicator(
        displacement: 0,
        strokeWidth: 0.75,
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          refreshModules();
        },
        child: LayoutBuilder(
          builder: (_, constrains) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    clipBehavior: Clip.antiAlias,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: constrains.maxWidth * 0.05,
                      ),
                      constraints: BoxConstraints(
                        minHeight: constrains.maxHeight,
                      ),
                      alignment: store.userStore.programSelected.homeLayout ==
                              HomeLayoutType.expansive
                          ? Alignment.center
                          : Alignment.topCenter,
                      child: ScopedBuilder(
                        store: store.programStore,
                        onState: (_, state) {
                          return _buildBodyWidget(
                            store.programStore.programSelected,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBodyWidget(ProgramModel program) {
    return ScopedBuilder<ModulesStore, DioError, List<ModuleModel>>(
      store: store.modulesStore,
      onLoading: (_) {
        switch (store.userStore.programSelected.homeLayout) {
          case HomeLayoutType.list:
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: store.modulesStore.state.length,
                itemBuilder: (context, index) => Column(
                  children: const [
                    ListModuleItemShimmerWidget(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          case HomeLayoutType.grid:
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: store.modulesStore.state.length,
                itemBuilder: (_, index) {
                  return const GridModuleItemShimmerWidget();
                },
              ),
            );
          case HomeLayoutType.expansive:
            return const HomeModulesGroupShimmerWidget();
          default:
            return const HomeModulesGroupShimmerWidget();
        }
      },
      onState: (_, state) {
        final StatusType status = program.status!;
        final StatusType statusPsp = program.statusPsp!;
        final bool isActive =
            status == StatusType.active && statusPsp == StatusType.active;
        if (!isActive) {
          return ProgramInactivateWidget(
            status: status,
            refreshModules: refreshModules,
          );
        }
        return _buildModulesWidget;
      },
      onError: (_, error) {
        return RequestErrorWidget(error: error, onPressed: refreshModules);
      },
    );
  }

  Widget get _buildModulesWidget {
    return TripleBuilder<ModulesStore, Exception, List<ModuleModel>>(
      store: store.modulesStore,
      builder: (_, triple) {
        final bool anyCategory = triple.state.any((module) {
          return module.category == ModuleCategoryType.diagnosis ||
              module.category == ModuleCategoryType.treatment ||
              module.category == ModuleCategoryType.prevent ||
              module.category == ModuleCategoryType.benefits;
        });
        if (!anyCategory) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: EmptyWidget(
                message: HomeLabels.homeLayoutEmptyMessage,
                textButton: HomeLabels.homeLayoutEmptyButton,
                onPressed: refreshModules,
                isDisabled: triple.isLoading,
              ),
            ),
          );
        }
        return Opacity(
          opacity: triple.isLoading ? 0.5 : 1.0,
          child: AbsorbPointer(
            absorbing: triple.isLoading,
            child: _buildModuleCategoriesWidget(triple.state),
          ),
        );
      },
    );
  }

  Widget _buildModuleCategoriesWidget(List<ModuleModel> modules) {
    return ScopedBuilder(
      store: store.categoryStore,
      onState: (_, state) {
        if (store.userStore.programSelected.homeLayout ==
            HomeLayoutType.expansive) {
          return Column(
            children: [
              HomeModulesGroupWidget(
                modules: modules.where((module) {
                  return module.category == ModuleCategoryType.diagnosis;
                }).toList(),
                scrollController: scrollController,
                moduleCategory: ModuleCategoryType.diagnosis,
                isOpened: state == ModuleCategoryType.diagnosis,
              ),
              const SizedBox(height: 20),
              HomeModulesGroupWidget(
                modules: modules.where((module) {
                  return module.category == ModuleCategoryType.treatment;
                }).toList(),
                scrollController: scrollController,
                moduleCategory: ModuleCategoryType.treatment,
                isOpened: state == ModuleCategoryType.treatment,
              ),
              const SizedBox(height: 20),
              HomeModulesGroupWidget(
                modules: modules.where((module) {
                  return module.category == ModuleCategoryType.prevent;
                }).toList(),
                scrollController: scrollController,
                moduleCategory: ModuleCategoryType.prevent,
                isOpened: state == ModuleCategoryType.prevent,
              ),
              const SizedBox(height: 20),
              HomeModulesGroupWidget(
                modules: modules.where((module) {
                  return module.category == ModuleCategoryType.benefits;
                }).toList(),
                scrollController: scrollController,
                moduleCategory: ModuleCategoryType.benefits,
                isOpened: state == ModuleCategoryType.benefits,
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Scrollbar(
                controller: scrollController,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildCategoryGroupWidget(
                        modules,
                        ModuleCategoryType.diagnosis,
                      ),
                      _buildCategoryGroupWidget(
                        modules,
                        ModuleCategoryType.treatment,
                      ),
                      _buildCategoryGroupWidget(
                        modules,
                        ModuleCategoryType.prevent,
                      ),
                      _buildCategoryGroupWidget(
                        modules,
                        ModuleCategoryType.benefits,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildCategoryGroupWidget(
    List<ModuleModel> modules,
    ModuleCategoryType category,
  ) {
    final List<ModuleModel> modules0 = modules.where((module) {
      return module.category == category;
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (modules0.isNotEmpty &&
            modules0[0].type != ModuleType.urgencyAttendance)
          Text(
            category.name,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        if (modules0.isNotEmpty) const Divider(),
        ScopedBuilder<UserStore, Exception, PreferencesModel>(
          store: store.userStore,
          onState: (_, prefs) {
            if (modules0.isEmpty) {
              return Container();
            }
            switch (store.userStore.programSelected.homeLayout) {
              case HomeLayoutType.list:
                if (modules0[0].type != ModuleType.urgencyAttendance) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: modules0.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return _buildListItemWidget(modules0[index]);
                    },
                  );
                }
                return Container();
              case HomeLayoutType.grid:
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: modules0.length,
                  itemBuilder: (_, index) {
                    return _buildGridItemWidget(modules0[index]);
                  },
                );
              default:
                return const SizedBox();
            }
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildListItemWidget(ModuleModel module) {
    return ListModuleItemWidget(
      module: module,
      navigate: store.modulesStore.navigate,
      asset: module.type.asset(module.type),
      assetBase: module.type.assetBase(module.type),
    );
  }

  Widget _buildGridItemWidget(ModuleModel module) {
    return GridModuleItemWidget(
      canTap: true,
      isFirst: true,
      module: module,
      navigate: store.modulesStore.navigate,
      asset: module.type.asset(module.type),
      assetBase: module.type.assetBase(module.type),
    );
  }
}
