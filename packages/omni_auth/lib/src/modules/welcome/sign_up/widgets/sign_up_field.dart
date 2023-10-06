import 'package:flutter/material.dart';

class SignUpField extends StatelessWidget {
  const SignUpField();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: 354 * fem,
      height: 80 * fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // kVM (I5101:11928;1302:19329;1302:19093)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
            padding: EdgeInsets.fromLTRB(24 * fem, 15 * fem, 24 * fem, 7 * fem),
            width: 335 * fem,
            height: 56 * fem,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffededf1)),
              borderRadius: BorderRadius.circular(60 * fem),
            ),
            child: Container(
              // autogroupciufSd5 (MYmP4iCEs96m6dc7nHCiUF)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 193 * fem, 0 * fem),
              width: 94 * fem,
              height: double.infinity,
              child: Container(
                // Nmd (I5101:11928;1302:19329;1302:19095)
                width: double.infinity,
                height: double.infinity,
                child: Text(
                  'Full name',
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.6000000238 * ffem / fem,
                    color: Color(0xff878da0),
                  ),
                ),
              ),
            ),
          ),
          Container(
            // captionJ9V (I5101:11928;1302:19329;1302:19102)
            margin: EdgeInsets.fromLTRB(24 * fem, 0 * fem, 0 * fem, 0 * fem),
            child: Text(
              'Caption text, description, notification',
              style: TextStyle(
                fontSize: 12 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.3333333333 * ffem / fem,
                color: Color(0xff878da0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
