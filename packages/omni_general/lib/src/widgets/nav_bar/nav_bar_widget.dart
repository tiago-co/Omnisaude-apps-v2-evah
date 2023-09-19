import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/src/core/enums/nav_bar_enum.dart' show LeadingType;

class NavBarWidget extends StatelessWidget {
  final LeadingType leadingType;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final String title;

  final Object? argsCallback;

  const NavBarWidget({
    Key? key,
    this.actions = const [],
    this.leadingType = LeadingType.back,
    required this.title,
    this.argsCallback,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context, argsCallback),
        child: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerLeft,
          child: _buildLeadingWidget(context),
        ),
      ),
      centerTitle: true,
      title: Tooltip(
        message: title,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      elevation: 0.5,
      bottom: bottom,
      shadowColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: actions,
    );
  }

  Widget _buildLeadingWidget(BuildContext context) {
    switch (leadingType) {
      case LeadingType.close:
        return SvgPicture.asset(
          Assets.close,
          color: Theme.of(context).primaryColor,
          height: 20,
          width: 20,
          package: AssetsPackage.omniGeneral,
        );
      case LeadingType.back:
        return SvgPicture.asset(
          Assets.arrowLeft,
          height: 20,
          width: 20,
          package: AssetsPackage.omniGeneral,
          color: Theme.of(context).primaryColor,
        );
      default:
        return SvgPicture.asset(
          Assets.arrowLeft,
          color: Theme.of(context).primaryColor,
          height: 20,
          width: 20,
          package: AssetsPackage.omniGeneral,
        );
    }
  }
}
