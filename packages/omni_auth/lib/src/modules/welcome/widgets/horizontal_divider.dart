import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // frame622uYb (4511:30456)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 28 * fem),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // line2dDh (4511:30457)
            margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 0 * fem),
            width: 145 * fem,
            height: 1 * fem,
            decoration: BoxDecoration(
              color: Color(0xffededf1),
            ),
          ),
          SizedBox(
            width: 14 * fem,
          ),
          Text(
            // orLP1 (4511:30458)
            'or',
            style: TextStyle(
              fontSize: 16 * ffem,
              fontWeight: FontWeight.w400,
              height: 1.6000000238 * ffem / fem,
              color: Color(0xff1a1c22),
            ),
          ),
          SizedBox(
            width: 14 * fem,
          ),
          Container(
            // line14Zu (4511:30459)
            margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 0 * fem, 0 * fem),
            width: 145 * fem,
            height: 1 * fem,
            decoration: BoxDecoration(
              color: Color(0xffededf1),
            ),
          ),
        ],
      ),
    );
  }
}
