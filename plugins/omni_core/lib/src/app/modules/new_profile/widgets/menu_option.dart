import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final Widget leadingIcon;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leadingIcon,
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}
