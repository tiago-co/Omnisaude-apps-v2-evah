import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/omni_general.dart';

class ModuleBannerWidget extends StatelessWidget {
  final AnimationController? animationController;
  final String url;
  final bool canTap;
  final bool isLast;
  final bool isFirst;
  final String asset;
  final bool isPrimary;
  final bool closeModal;
  final String assetBase;
  final ModuleModel? module;
  final Function(ModuleModel) navigate;

  const ModuleBannerWidget({
    Key? key,
    this.module,
    this.asset = '',
    this.assetBase = '',
    required this.url,
    this.canTap = false,
    this.isLast = false,
    this.isFirst = false,
    this.isPrimary = false,
    this.closeModal = false,
    this.animationController,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canTap
          ? () async {
              if (closeModal) Navigator.pop(context);
              await animationController?.reverse();
              navigate(module!);
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: isFirst
              ? const BorderRadiusDirectional.only(
                  topStart: Radius.circular(500),
                  topEnd: Radius.circular(500),
                )
              : isLast
                  ? const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(500),
                      bottomEnd: Radius.circular(500),
                    )
                  : null,
          color: animationController == null
              ? null
              : animationController!.isDismissed
                  ? null
                  : Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              color: isFirst
                  ? animationController == null
                      ? null
                      : animationController!.isDismissed
                          ? null
                          : Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                if (isPrimary || url.isEmpty)
                  _buildModuleCategoryBanner(context),
                if (!isPrimary && url.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AbsorbPointer(
                      child: ImageWidget(
                        url: url,
                        width: 40,
                        height: 40,
                        asset: asset,
                        assetBase: assetBase,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 40,
                  child: SvgPicture.asset(
                    Assets.baseModule,
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    package: AssetsPackage.omniGeneral,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCategoryBanner(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          assetBase,
          width: 40,
          height: 40,
          color: isFirst
              ? animationController == null
                  ? Theme.of(context).cardColor
                  : animationController!.isDismissed
                      ? Theme.of(context).cardColor
                      : Colors.white
              : Theme.of(context).primaryColor,
          package: AssetsPackage.omniGeneral,
        ),
        SvgPicture.asset(
          asset,
          width: 40,
          height: 40,
          color: isFirst
              ? animationController == null
                  ? Theme.of(context).primaryColor
                  : animationController!.isDismissed
                      ? Theme.of(context).primaryColor
                      : Colors.white
              : Theme.of(context).primaryColor,
          package: AssetsPackage.omniGeneral,
        ),
      ],
    );
  }
}
