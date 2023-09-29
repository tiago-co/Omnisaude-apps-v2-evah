import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // autogrouppwithJf (MYo17g9ZnJxT8yueKPPWiT)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 28 * fem),
      width: double.infinity,
      height: 40 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // frame1522CmD (4511:32297)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 125 * fem, 0 * fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // ellipse132XHh (I4511:32298;1302:23395)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  width: 40 * fem,
                  height: 40 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20 * fem),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/ui/images/ellipse-132-bg-hew.png',
                      ),
                    ),
                  ),
                ),
                RichText(
                  // heyjoanapXh (4511:32299)
                  text: TextSpan(
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2999999306 * ffem / fem,
                      color: Color(0xff1a1c22),
                    ),
                    children: [
                      TextSpan(
                        text: 'Hey, ',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2999999306 * ffem / fem,
                          color: Color(0xff52576a),
                        ),
                      ),
                      TextSpan(
                        text: 'Joana',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2999999306 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            // iconsQPR (4511:32300)
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              width: 40 * fem,
              height: 40 * fem,
              child: Image.asset(
                'assets/ui/images/icons.png',
                width: 40 * fem,
                height: 40 * fem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
