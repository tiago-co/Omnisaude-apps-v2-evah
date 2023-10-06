import 'package:flutter/material.dart';

class WelcomeFormField extends StatelessWidget {
  const WelcomeFormField();

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
            // captionzBR (I4511:30485;1302:19305;1302:19102)
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
          Container(
            // 2rs (I4511:30485;1302:19305;1302:19093)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
            padding: EdgeInsets.fromLTRB(24 * fem, 15 * fem, 24 * fem, 7 * fem),
            width: 335 * fem,
            height: 56 * fem,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffededf1)),
              borderRadius: BorderRadius.circular(60 * fem),
            ),
            child: Container(
              // autogroupt4gfLcf (MYmG1kH1Y2NysYHAzgT4gf)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 193 * fem, 0 * fem),
              width: 94 * fem,
              height: double.infinity,
              child: Container(
                // sMh (I4511:30485;1302:19305;1302:19095)
                width: double.infinity,
                height: double.infinity,
                child: Text(
                  'Email',
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
        ],
      ),
    );
  }
}
