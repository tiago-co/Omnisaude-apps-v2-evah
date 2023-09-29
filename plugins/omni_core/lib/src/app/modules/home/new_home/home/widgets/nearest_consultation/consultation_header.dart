import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class ConsultationHeader extends StatelessWidget {
  const ConsultationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // datestatusxD5 (I4511:32375;4508:27494)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
      width: double.infinity,
      height: 28 * fem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // frame1510ftB (I4511:32375;3902:11778)
            margin: EdgeInsets.fromLTRB(0 * fem, 4 * fem, 70 * fem, 4 * fem),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // frame1505bmq (I4511:32375;3902:11779)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 0 * fem),
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // calendarXfV (I4511:32375;3902:11780)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 4 * fem, 0 * fem),
                        width: 16 * fem,
                        height: 16 * fem,
                        child: Image.asset(
                          'assets/ui/images/calendar-RPd.png',
                          width: 16 * fem,
                          height: 16 * fem,
                        ),
                      ),
                      Text(
                        // S1m (I4511:32375;3902:11781)
                        '27/04',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4000000272 * ffem / fem,
                          color: Color(0xff878da0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // frame1506mZq (I4511:32375;3902:11782)
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // timeclockKLT (I4511:32375;3902:11783)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 4 * fem, 0 * fem),
                        width: 16 * fem,
                        height: 16 * fem,
                        child: Image.asset(
                          'assets/ui/images/time-clock-JmD.png',
                          width: 16 * fem,
                          height: 16 * fem,
                        ),
                      ),
                      Text(
                        // amETR (I4511:32375;3902:11784)
                        '11:57am',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4000000272 * ffem / fem,
                          color: Color(0xff878da0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // statusmy9 (I4511:32375;3902:11785)
            width: 90 * fem,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffecf9f6),
              borderRadius: BorderRadius.circular(40 * fem),
            ),
            child: Center(
              child: Text(
                'Approved',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.4000000272 * ffem / fem,
                  color: Color(0xff47bec1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
