import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/omni_general.dart'
    show Helpers, ImageWidget, ModuleModel;

class ListModuleItemWidget extends StatefulWidget {
  final String asset;
  final String assetBase;
  final ModuleModel module;
  final Function(ModuleModel) navigate;

  const ListModuleItemWidget({
    Key? key,
    required this.module,
    this.asset = '',
    this.assetBase = '',
    required this.navigate,
  }) : super(key: key);

  @override
  _ListModuleItemWidgetState createState() => _ListModuleItemWidgetState();
}

class _ListModuleItemWidgetState extends State<ListModuleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.navigate(widget.module),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(0.025),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                if (widget.module.cardBanner == null ||
                    widget.module.cardBanner!.isEmpty)
                  _buildModuleCategoryBannerWidget(context),
                if (widget.module.cardBanner != null &&
                    widget.module.cardBanner!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageWidget(
                      url: widget.module.cardBanner!,
                      width: 30,
                      height: 30,
                      asset: widget.asset,
                      assetBase: widget.assetBase,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 30,
                  child: SvgPicture.asset(
                    Assets.baseModule,
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    package: AssetsPackage.omniGeneral,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Tooltip(
                message: widget.module.name ?? '',
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    widget.module.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          // fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              Assets.arrowRight,
              package: AssetsPackage.omniGeneral,
              color: Theme.of(context).primaryColor,
              width: 15,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCategoryBannerWidget(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Helpers.showDialog(
          context,
          Container(
            alignment: Alignment.center,
            color: Colors.red,
            height: 900,
          ),
          showClose: true,
        );
      },
      child: Stack(
        children: [
          SvgPicture.asset(
            widget.assetBase,
            width: 30,
            height: 30,
            color: Theme.of(context).cardColor,
            package: AssetsPackage.omniGeneral,
          ),
          SvgPicture.asset(
            widget.asset,
            width: 30,
            height: 30,
            color: Theme.of(context).primaryColor,
            package: AssetsPackage.omniGeneral,
          ),
        ],
      ),
    );
  }
}
