import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';

class TermsItemWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;

  const TermsItemWidget({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(width: 15),
            SvgPicture.asset(
              Assets.arrowRight,
              package: AssetsPackage.omniGeneral,
              color: Colors.black54,
              width: 15,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
