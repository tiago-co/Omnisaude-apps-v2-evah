import 'package:flutter/material.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // scheduleschedulebAw (5103:12314)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
      width: double.infinity,
      height: 90 * fem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x0f1f2023),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 8 * fem,
          ),
          BoxShadow(
            color: Color(0xffffcccc),
            offset: Offset(-4 * fem, 0),
            blurRadius: 0,
          ),
        ],
      ),
      child: Container(
        // component5VGK (I5103:12314;4511:32354)
        padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 0 * fem, 16 * fem),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffEEEEF2)),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12 * fem),
        ),
        child: Container(
          // frame1530mzX (I5103:12314;4511:32357)
          width: 179 * fem,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // frame15327oV (I5103:12314;4511:32358)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        // timeclockT6f (I5103:12314;4511:32359)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 4 * fem, 0 * fem),
                        width: 16 * fem,
                        height: 16 * fem,
                        child: Icon(
                          Icons.watch_later_outlined,
                          size: 12,
                        )),
                    Text(
                      // amxZD (I5103:12314;4511:32360)
                      '9:30am',
                      style: TextStyle(
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.4000000272 * ffem / fem,
                        color: Color(0xff878da0),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                // takethedrugah225VJF (I5103:12314;4511:32361)
                'Tomar "Ibuprofeno"',
                style: TextStyle(
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.6000000238 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
