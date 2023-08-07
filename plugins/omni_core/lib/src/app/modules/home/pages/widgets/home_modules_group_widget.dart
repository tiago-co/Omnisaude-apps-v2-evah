import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/module_category_store.dart';
import 'package:omni_core/src/app/shared/widgets/module_banner/module_banner_widget.dart';
import 'package:omni_general/omni_general.dart';

class HomeModulesGroupWidget extends StatefulWidget {
  final List<ModuleModel> modules;
  final ModuleCategoryType moduleCategory;
  final ScrollController scrollController;
  final bool isOpened;

  const HomeModulesGroupWidget({
    Key? key,
    required this.modules,
    required this.moduleCategory,
    required this.scrollController,
    required this.isOpened,
  }) : super(key: key);

  @override
  _HomeModulesGroupWidgetState createState() => _HomeModulesGroupWidgetState();
}

class _HomeModulesGroupWidgetState extends State<HomeModulesGroupWidget>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 350);
  final ModuleCategoryStore categoryStore = Modular.get();
  final ModulesStore modulesStore = Modular.get();
  late AnimationController animationController;
  late String assetBase;
  late String asset;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    switch (widget.moduleCategory) {
      case ModuleCategoryType.diagnosis:
        asset = Assets.diagnosisOne;
        assetBase = Assets.diagnosisTwo;
        break;
      case ModuleCategoryType.treatment:
        asset = Assets.treatmentOne;
        assetBase = Assets.treatmentTwo;
        break;
      case ModuleCategoryType.prevent:
        asset = Assets.preventionOne;
        assetBase = Assets.preventionTwo;
        break;
      case ModuleCategoryType.benefits:
        asset = Assets.benefitsOne;
        assetBase = Assets.benefitsTwo;
        break;
      default:
        asset = Assets.test;
        assetBase = Assets.test;
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeModulesGroupWidget oldWidget) {
    if (animationController.isCompleted) {
      animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  void openModuleCategory() {
    if (animationController.isDismissed) {
      categoryStore.categoryOpened(widget.moduleCategory);
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.modules.isEmpty) return Container();
    if (!widget.isOpened) animationController.reverse();
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, child) {
        return Column(
          children: [
            InkWell(
              onTap: openModuleCategory,
              borderRadius: BorderRadius.circular(500),
              highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
              splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
              child: Row(
                children: [
                  Expanded(child: _buildModuleGroupTitleWidget),
                  const SizedBox(width: 15),
                  ModuleBannerWidget(
                    url: '',
                    isFirst: true,
                    animationController: animationController,
                    navigate: modulesStore.navigate,
                    asset: asset,
                    isPrimary: true,
                    assetBase: assetBase,
                  ),
                ],
              ),
            ),
            _buildModuleGroupDetails,
          ],
        );
      },
    );
  }

  Widget get _buildModuleGroupTitleWidget {
    return Container(
      constraints: const BoxConstraints(maxHeight: 80),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          widget.moduleCategory.name,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }

  Widget get _buildModuleGroupDetails {
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    if (animation.value > 0) {
      if (widget.moduleCategory != ModuleCategoryType.diagnosis) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: duration,
          curve: Curves.decelerate,
        );
      } else {
        widget.scrollController.animateTo(
          0,
          duration: duration,
          curve: Curves.decelerate,
        );
      }
    }
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Column(
          children: widget.modules
              .map((module) => _buildModuleItemWidget(module))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildModuleItemWidget(ModuleModel module) {
    return InkWell(
      onTap: () async {
        await animationController.reverse();
        modulesStore.navigate(module);
      },
      borderRadius: BorderRadius.circular(500),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 80),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _buildModuleTitleWidget(module.name ?? ''),
              ),
            ),
          ),
          const SizedBox(width: 15),
          ModuleBannerWidget(
            url: module.cardBanner ?? '',
            asset: module.type.asset(module.type),
            assetBase: module.type.assetBase(module.type),
            isLast: module == widget.modules.last,
            animationController: animationController,
            navigate: modulesStore.navigate,
          ),
        ],
      ),
    );
  }

  Widget _buildModuleTitleWidget(String title) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
