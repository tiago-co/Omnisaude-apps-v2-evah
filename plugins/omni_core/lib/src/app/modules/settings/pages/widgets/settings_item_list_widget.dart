import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsItemListWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  IconData? icon;
  final bool? showTrailingIcon;
  final Widget? trailing;

  SettingsItemListWidget({
    Key? key,
    this.onTap,
    this.trailing,
    this.icon,
    required this.title,
    this.showTrailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListTile(
        minLeadingWidth: 30,
        onTap: onTap,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor.withOpacity(0.035),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
        trailing: showTrailingIcon == true
            ? Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).cardColor,
                size: 20,
              )
            : trailing,
      ),
    );
  }
}
