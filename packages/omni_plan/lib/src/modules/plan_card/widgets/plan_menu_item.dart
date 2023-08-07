import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlanMenuItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String asset;
  final String? package;
  final String? assetBase;
  final bool? showTrailingIcon;

  const PlanMenuItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.asset,
    this.assetBase,
    this.package,
    this.showTrailingIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListTile(
          minVerticalPadding: 0,
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor.withOpacity(0.025),
            ),
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                if (assetBase != null)
                  SvgPicture.asset(
                    assetBase!,
                    package: package,
                    color: Theme.of(context).cardColor,
                    width: 30,
                    height: 30,
                  ),
                SvgPicture.asset(
                  asset,
                  package: package,
                  color: Theme.of(context).primaryColor,
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          title: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: showTrailingIcon!
              ? Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  size: 30,
                )
              : null,
        ),
      ),
    );
  }
}
