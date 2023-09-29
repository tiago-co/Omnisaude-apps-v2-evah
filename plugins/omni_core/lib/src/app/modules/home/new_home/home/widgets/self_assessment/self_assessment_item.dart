import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class SelfAssessmentItem extends StatelessWidget {
  const SelfAssessmentItem({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // group46jsM (4511:32380)
      width: 335 * fem,
      height: 96 * fem,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0f1f2023),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 8 * fem,
          ),
        ],
      ),
      child: Container(
        // component53d9 (4511:32381)
        padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
        width: double.infinity,

        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffededf1)),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12 * fem),
        ),
        child: Container(
          // frame1512wiX (4511:32383)
          width: 165 * fem,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // frame1510VEF (4511:32385)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 21 * fem, 12 * fem),
                width: double.infinity,
                height: 20 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame1505oVq (4511:32386)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 10 * fem, 0 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // calendar8o1 (4511:32387)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 4 * fem, 0 * fem),
                            width: 16 * fem,
                            height: 16 * fem,
                            child: Image.asset(
                              'assets/ui/images/calendar-7rw.png',
                              width: 16 * fem,
                              height: 16 * fem,
                            ),
                          ),
                          Text(
                            // Soh (4511:32388)
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
                      // frame1506PU3 (4511:32389)
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timeclockLPH (4511:32390)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 4 * fem, 0 * fem),
                            width: 16 * fem,
                            height: 16 * fem,
                            child: Image.asset(
                              'assets/ui/images/time-clock-WsR.png',
                              width: 16 * fem,
                              height: 16 * fem,
                            ),
                          ),
                          Text(
                            // amShD (4511:32391)
                            '11:25am',
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
                // frame1511Beo (4511:32392)
                width: double.infinity,

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // group458K9 (4511:32393)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 8 * fem, 0 * fem),
                      width: 32 * fem,

                      decoration: BoxDecoration(
                        color: Color(0xffecf9f6),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Center(
                        child: Center(
                          child: Text(
                            '4',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.6000000238 * ffem / fem,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      // acuteheadachen8o (4511:32396)
                      'Acute headache',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.6000000238 * ffem / fem,
                        color: Color(0xff1a1c22),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
