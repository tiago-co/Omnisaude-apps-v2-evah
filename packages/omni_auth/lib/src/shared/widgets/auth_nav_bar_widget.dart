import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';

class AuthNavBarWidget extends StatelessWidget {
  final VoidCallback? onLeadingPress;

  const AuthNavBarWidget({Key? key, this.onLeadingPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Theme.of(context).colorScheme.background,
      leading: GestureDetector(
        onTap: onLeadingPress ?? () => Navigator.pop(context),
        child: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            Assets.arrowLeft,
            color: Theme.of(context).primaryColor.withOpacity(1),
            package: AssetsPackage.omniGeneral,
            width: 20,
            height: 20,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }
}
