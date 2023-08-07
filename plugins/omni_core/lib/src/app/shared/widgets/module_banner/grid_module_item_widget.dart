import 'package:flutter/material.dart';
import 'package:omni_core/src/app/shared/widgets/module_banner/module_banner_widget.dart';
import 'package:omni_general/omni_general.dart';

class GridModuleItemWidget extends StatefulWidget {
  final bool canTap;
  final String asset;
  final bool isFirst;
  final bool isPrimary;
  final bool closeModal;
  final String assetBase;
  final ModuleModel? module;
  final Function(ModuleModel) navigate;
  final AnimationController? animationController;

  const GridModuleItemWidget({
    Key? key,
    this.module,
    this.asset = '',
    this.assetBase = '',
    this.canTap = false,
    this.isPrimary = false,
    this.isFirst = false,
    this.closeModal = false,
    this.animationController,
    required this.navigate,
  }) : super(key: key);

  @override
  _GridModuleItemWidgetState createState() => _GridModuleItemWidgetState();
}

class _GridModuleItemWidgetState extends State<GridModuleItemWidget>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(seconds: 1);
  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animationController.repeat();
    animationController.animateTo(1.0);
    sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      animationController,
    );
    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                // padding: const EdgeInsets.only(top: 5),
                child: ClipRect(
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: Center(
                          child: ModuleBannerWidget(
                            asset: widget.asset,
                            module: widget.module,
                            canTap: widget.canTap,
                            isFirst: widget.isFirst,
                            navigate: widget.navigate,
                            assetBase: widget.assetBase,
                            closeModal: widget.closeModal,
                            url: widget.module?.cardBanner ?? '',
                            animationController: widget.animationController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Tooltip(
              message: widget.module?.name ?? '',
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    widget.module?.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
