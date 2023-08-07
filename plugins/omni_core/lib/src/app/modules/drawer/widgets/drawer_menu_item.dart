import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerMenuItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String asset;
  final String? package;
  final String? assetBase;
  final bool? showTrailingIcon;

  const DrawerMenuItem({
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
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //   child: Row(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: Theme.of(context).cardColor.withOpacity(0.025),
      //         ),
      //         padding: const EdgeInsets.all(5),
      //         child: Stack(
      //           children: [
      //             if (assetBase != null)
      //               SvgPicture.asset(
      //                 assetBase!,
      //                 package: package,
      //                 color: Theme.of(context).cardColor,
      //                 width: 30,
      //                 height: 30,
      //               ),
      //             SvgPicture.asset(
      //               asset,
      //               package: package,
      //               color: Theme.of(context).primaryColor,
      //               width: 30,
      //               height: 30,
      //             ),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(width: 15),
      //       Expanded(
      //         child: Text(
      //           title,
      //           maxLines: 2,
      //           overflow: TextOverflow.ellipsis,
      //           style: Theme.of(context).textTheme.headlineSmall,
      //         ),
      //       ),
      //       const SizedBox(width: 15),
      //       if (showTrailingIcon == true)
      //         SvgPicture.asset(
      //           Assets.arrowRight,
      //           package: AssetsPackage.omniGeneral,
      //           color: Theme.of(context).cardColor,
      //           width: 15,
      //           height: 15,
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
