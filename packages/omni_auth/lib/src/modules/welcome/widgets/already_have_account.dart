import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Center(
      // alreadyhaveanaccountsigninvVd (5101:11635)
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: SafeGoogleFont(
              'Inter',
              fontSize: 16 * ffem,
              fontWeight: FontWeight.w600,
              height: 1.5 * ffem / fem,
              color: Color(0xff1a1c22),
            ),
            children: [
              TextSpan(
                text: 'Already have an account?',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.6000000238 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
              TextSpan(
                text: ' ',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.5 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
              TextSpan(
                text: 'Sign In',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.5 * ffem / fem,
                  color: Color(0xff2d72b3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
