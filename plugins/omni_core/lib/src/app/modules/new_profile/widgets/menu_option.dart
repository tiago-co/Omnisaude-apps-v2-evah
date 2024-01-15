import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.fem = 0,
  }) : super(key: key);
  final Widget leadingIcon;
  final String title;
  final Function()? onTap;
  final double fem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leadingIcon,
      title: Text(
        title,
        style: TextStyle(fontSize: 14 * fem),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}
