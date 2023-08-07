import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:informative_labels/labels.dart';
import 'package:omni_core/src/app/core/models/category_informative_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/omni_general.dart';

class InformativeCategoryItemWidget extends StatefulWidget {
  final CategoryInformativeModel category;

  const InformativeCategoryItemWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _InformativeCategoryItemWidgetState createState() =>
      _InformativeCategoryItemWidgetState();
}

class _InformativeCategoryItemWidgetState
    extends State<InformativeCategoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          'informatives',
          arguments: widget.category.name ??
              InformativeLabels.informativeCategoryItemTitlePlaceholder,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).cardColor.withOpacity(0.5),
            width: 0.1,
          ),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: -5,
              color: Theme.of(context).cardColor,
            ),
          ],
        ),
        height: 120,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AbsorbPointer(
                child: ImageWidget(
                  url: widget.category.banner ?? '',
                  asset: Assets.informativeCategoryItem,
                  package: AssetsPackage.omniCore,
                  boxFit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            Container(
              height: 350.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).primaryColor.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.category.name ??
                        InformativeLabels
                            .informativeCategoryItemNamePlaceholder,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
