import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // autogroupqpovnko (MYmF9wNfqcUm4f14wJQPoV)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // socialbuttonWgo (4511:30460)

              height: 48 * fem,
              child: Image.asset(
                'assets/ui/images/social-button.png',
                width: 157 * fem,
                height: 48 * fem,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              // socialbuttonoA7 (4511:30461)
              width: 159 * fem,
              height: 48 * fem,
              child: Image.asset(
                'assets/ui/images/social-button-2hm.png',
                width: 159 * fem,
                height: 48 * fem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
