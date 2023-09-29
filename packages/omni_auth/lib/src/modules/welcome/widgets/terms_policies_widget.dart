import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class TermsPoliciesWidget extends StatelessWidget {
  const TermsPoliciesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // pleasereadthetermsandpoliciesb (5101:11629)
      margin: EdgeInsets.fromLTRB(0 * fem, 8 * fem, 19 * fem, 8 * fem),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 321 * fem,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: SafeGoogleFont(
                'Inter',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.6000000238 * ffem / fem,
                color: Color(0xff1a1c22),
              ),
              children: [
                TextSpan(
                  text: 'Please read the ',
                ),
                TextSpan(
                  text: 'Terms and policies',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff2d72b3),
                  ),
                ),
                TextSpan(
                  text: ' before registering',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
