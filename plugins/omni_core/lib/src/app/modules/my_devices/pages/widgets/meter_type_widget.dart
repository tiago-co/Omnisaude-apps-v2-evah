import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

class MeterTypeWidget extends StatelessWidget {
  final String title;
  final String asset;
  final String package;
  final GestureTapCallback? onTap;
  const MeterTypeWidget({
    Key? key,
    required this.title,
    required this.asset,
    required this.package,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor.withOpacity(0.025),
              ),
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                asset,
                package: package,
                color: Theme.of(context).primaryColor,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black.withOpacity(0.75),
                    ),
              ),
            ),
            const SizedBox(width: 15),
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
}
