import 'package:flutter/material.dart';
import 'package:myapp/ui/welcome/widgets/welcome_form_field.dart';
import 'package:myapp/utils.dart';

class WelcomeForm extends StatelessWidget {
  const WelcomeForm({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // frame1502wQB (4511:30484)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 28 * fem),
      width: double.infinity,
      height: 216 * fem,
      child: Stack(
        children: [
          Positioned(
            left: 0 * fem,
            top: 0 * fem,
            child: const WelcomeFormField(),
          ),
          Positioned(
            left: 0 * fem,
            top: 68 * fem,
            child: const WelcomeFormField(),
          ),
          Positioned(
            left: 0 * fem,
            top: 136 * fem,
            child: const WelcomeFormField(),
          ),
        ],
      ),
    );
  }
}
