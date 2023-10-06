import 'package:flutter/material.dart';

class WelcomeFormField extends StatelessWidget {
  const WelcomeFormField(
      {required this.label, this.isPassword = false, this.suffixIcon, Key? key})
      : super(key: key);
  final String label;
  final bool isPassword;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 24,
            right: 12,
            top: 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffededf1),
            ),
            borderRadius: BorderRadius.circular(60),
          ),
          child: TextFormField(
            obscureText: isPassword,
            cursorColor: const Color(0xff2D73B3),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: isPassword
                  ? Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.grey,
                    )
                  : suffixIcon,
              contentPadding: EdgeInsets.zero,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
