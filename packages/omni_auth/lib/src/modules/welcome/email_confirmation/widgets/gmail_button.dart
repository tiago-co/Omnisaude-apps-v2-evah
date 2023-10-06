import 'package:flutter/material.dart';

class GmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 301;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
        // masterbuttonmaster2P1 (I202:13935;201:22697)
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0.5 * fem, 16 * fem, 0.5 * fem, 16 * fem),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffededf1)),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(60 * fem),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // iconssocialiconsvjH (I202:13935;201:22697;19:7257)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 0 * fem),
                width: 20 * fem,
                height: 20 * fem,
                child: Image.asset(
                  'assets/ui/images/icons-social-icons-J2K.png',
                  width: 20 * fem,
                  height: 20 * fem,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 8 * fem, 0 * fem),
                child: Text(
                  'Open Gmail',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              Container(
                // openinnewweP (I202:13935;201:22697;19:7261)
                width: 24 * fem,
                height: 24 * fem,
                child: Image.asset(
                  'assets/ui/images/openinnew.png',
                  width: 24 * fem,
                  height: 24 * fem,
                ),
              ),
            ],
          ),
        ));
  }
}
