import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class NearestConsultationWidget extends StatelessWidget {
  const NearestConsultationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // frame1509tdD (4511:32371)

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // group43qYT (4511:32372)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * fem),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // nearestconsultationMWo (4511:32373)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: Text(
                    'Nearest consultation',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2999999306 * ffem / fem,
                      color: Color(0xff1a1c22),
                    ),
                  ),
                ),
                TextButton(
                  // masterbuttonmasterG7y (4902:28294)
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 104 * fem,
                    height: 24 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Container(
                      // boxNwh (I4902:28294;21:5984)
                      width: double.infinity,
                      height: double.infinity,
                      child: Container(
                        // autogroupbzr9YbH (MYo3dmcoXC3oq7vuZmBZR9)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: 51 * fem,
                        height: double.infinity,
                        child: Center(
                          child: Center(
                            child: Text(
                              'See all',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.5 * ffem / fem,
                                color: Color(0xff52576a),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // consultationziB (4511:32375)
            width: 335 * fem,
            height: 245 * fem,
            decoration: BoxDecoration(
              color: Color(0xfff1f8fd),
              borderRadius: BorderRadius.circular(12 * fem),
            ),
            child: Stack(
              children: [
                Positioned(
                  // autogroupuebhWwR (MYo3pr8gGDsbk2eoM8UeBh)
                  left: 0 * fem,
                  top: 119 * fem,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 16 * fem, 16 * fem, 16 * fem),
                    width: 335 * fem,
                    height: 126 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // frame537ovX (I4511:32375;3902:11769)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 16 * fem),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // doctorsnotejZH (I4511:32375;3902:11770)
                                'Doctor’s note',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238 * ffem / fem,
                                  color: Color(0xff1a1c22),
                                ),
                              ),
                              Text(
                                // preparealistofdiseasesofyourre (I4511:32375;3902:11772)
                                'Prepare a list of diseases of your relatives.',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4000000272 * ffem / fem,
                                  color: Color(0xff52576a),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // masterbuttonmasterBAP (I4511:32375;5321:17959;1301:14500)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 200 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              12 * fem, 4 * fem, 12 * fem, 4 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffdfedfb),
                            borderRadius: BorderRadius.circular(40 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // hyperlink3yH (I4511:32375;5321:17959;1301:14500;1301:14377)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 4 * fem, 0 * fem),
                                width: 16 * fem,
                                height: 16 * fem,
                                child: Image.asset(
                                  'assets/ui/images/hyperlink.png',
                                  width: 16 * fem,
                                  height: 16 * fem,
                                ),
                              ),
                              Center(
                                // textAHD (I4511:32375;5321:17959;1301:14500;1301:14378)
                                child: Text(
                                  'Receipts',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.7142857143 * ffem / fem,
                                    color: Color(0xff2d72b3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // frame6255f5 (I4511:32375;3902:11773)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 16 * fem, 16 * fem, 16 * fem),
                    width: 335 * fem,
                    height: 119 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xfff1f8fd)),
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(12 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // datestatusxD5 (I4511:32375;4508:27494)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 12 * fem),
                          width: double.infinity,
                          height: 28 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // frame1510ftB (I4511:32375;3902:11778)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 4 * fem, 70 * fem, 4 * fem),
                                height: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // frame1505bmq (I4511:32375;3902:11779)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // calendarXfV (I4511:32375;3902:11780)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 4 * fem, 0 * fem),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // timeclockKLT (I4511:32375;3902:11783)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 4 * fem, 0 * fem),
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
                        ),
                        Container(
                          // frame536U6s (I4511:32375;3902:11774)
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // joomorais1cb (I4511:32375;3902:11775)
                                'João Morais',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xff1a1c22),
                                ),
                              ),
                              Text(
                                // gynecologyandobstetricsMRZ (I4511:32375;3902:11777)
                                'Gynecology and obstetrics',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4000000272 * ffem / fem,
                                  color: Color(0xff52576a),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // masterbuttonmasterV1y (I4511:32375;3902:11789;1106:10392)
                  left: 211 * fem,
                  top: 197 * fem,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        14 * fem, 4 * fem, 23 * fem, 4 * fem),
                    width: 117 * fem,
                    height: 32 * fem,
                    decoration: BoxDecoration(
                      color: Color(0xff2d72b3),
                      borderRadius: BorderRadius.circular(40 * fem),
                    ),
                    child: Container(
                      // autogroupadc3Ato (MYo4W5WJvMe8CUsyAQadC3)
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Center(
                          child: Text(
                            'Reschedule',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.7142857143 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
