import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class PostsWidgets extends StatelessWidget {
  const PostsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // frame1520WqV (4511:32397)
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // group44sg3 (4511:32398)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 456 * fem, 12 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * fem),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  // yourhealthQR5 (4511:32399)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 162 * fem, 0 * fem),
                  child: Text(
                    'Your health',
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
                  // masterbuttonmasterXEo (4902:28283)
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
                      // boxqWP (I4902:28283;21:5984)
                      width: double.infinity,
                      height: double.infinity,
                      child: Container(
                        // autogroup85xtQ3h (MYo7KaeCy9K9tuTvMW85xT)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 53 * fem, 0 * fem),
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
            // articlefVR (4511:32401)
            width: double.infinity,
            height: 358 * fem,
            child: Stack(
              children: [
                Positioned(
                  // rectangle19PwD (I4511:32401;4504:25386)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 335 * fem,
                      height: 358 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12 * fem),
                          color: Color(0xfff1f8fd),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // rectangle20u8s (I4511:32401;4504:25387)
                  left: 16 * fem,
                  top: 16 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 303 * fem,
                      height: 180 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8 * fem),
                        child: Image.asset(
                          'assets/ui/images/rectangle-20-Jh5.png',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // frame1513QrK (I4511:32401;4504:25388)
                  left: 17 * fem,
                  top: 212 * fem,
                  child: Container(
                    width: 164 * fem,
                    height: 32 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // ellipse132Xvw (I4511:32401;4504:25389;1302:23395)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 8 * fem, 0 * fem),
                          width: 32 * fem,
                          height: 32 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16 * fem),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/ui/images/ellipse-132-bg-Hwu.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          // ronaldrichardsRmR (I4511:32401;4504:25390)
                          'Ronald Richards',
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
                ),
                Positioned(
                  // frame1505AU7 (I4511:32401;4504:25391)
                  left: 259 * fem,
                  top: 218 * fem,
                  child: Container(
                    width: 60 * fem,
                    height: 20 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // calendarghM (I4511:32401;4504:25392)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 4 * fem, 0 * fem),
                          width: 16 * fem,
                          height: 16 * fem,
                          child: Image.asset(
                            'assets/ui/images/calendar-BYb.png',
                            width: 16 * fem,
                            height: 16 * fem,
                          ),
                        ),
                        Text(
                          // zT9 (I4511:32401;4504:25393)
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
                ),
                Positioned(
                  // frame1478Xxs (I4511:32401;4504:25394)
                  left: 17 * fem,
                  top: 256 * fem,
                  child: Container(
                    width: 827 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // cardiovascularhealthSpw (I4511:32401;4504:25395)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 4 * fem),
                          child: Text(
                            'Cardiovascular health',
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                        ),
                        Text(
                          // exploringvariousmentalhealthco (I4511:32401;4504:25396)
                          'Exploring various mental health conditions, coping strategies, and the importance of seeking professional help when needed.\n',
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
                ),
                Positioned(
                  // frame15063Zq (I4511:32401;4504:25397)
                  left: 16 * fem,
                  top: 322 * fem,
                  child: Container(
                    width: 99 * fem,
                    height: 20 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // timeclockZYB (I4511:32401;4504:25398)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 4 * fem, 0 * fem),
                          width: 16 * fem,
                          height: 16 * fem,
                          child: Image.asset(
                            'assets/ui/images/time-clock-Qhm.png',
                            width: 16 * fem,
                            height: 16 * fem,
                          ),
                        ),
                        Text(
                          // minreadU9M (I4511:32401;4504:25399)
                          '20 min read',
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
                ),
                Positioned(
                  // frame1514QYo (I4511:32401;4504:25400)
                  left: 197 * fem,
                  top: 320 * fem,
                  child: Container(
                    width: 122 * fem,
                    height: 24 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // speechbubblejLB (I4511:32401;4504:25401)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 4 * fem, 0 * fem),
                          width: 16 * fem,
                          height: 16 * fem,
                          child: Image.asset(
                            'assets/ui/images/speech-bubble-2EB.png',
                            width: 16 * fem,
                            height: 16 * fem,
                          ),
                        ),
                        Text(
                          // comments35y (I4511:32401;4504:25402)
                          '243 comments',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.7142857143 * ffem / fem,
                            color: Color(0xff2d72b3),
                          ),
                        ),
                      ],
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
