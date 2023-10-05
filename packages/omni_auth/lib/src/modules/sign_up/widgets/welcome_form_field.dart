import 'package:flutter/material.dart';

class WelcomeFormField extends StatelessWidget {
  const WelcomeFormField({required this.label, Key? key}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffededf1),
            ),
            borderRadius: BorderRadius.circular(60),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.zero,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
