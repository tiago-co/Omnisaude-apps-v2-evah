import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      padding: EdgeInsets.fromLTRB(31.38 * fem, 8 * fem, 0 * fem, 8 * fem),
      width: 375 * fem,
      height: 84 * fem,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffededf1)),
        color: Color(0xffffffff),
      ),
      child: Container(
        // frame1581qnX (I4511:32402;4504:25405)
        width: double.infinity,
        height: 43 * fem,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // componentnBy (I4511:32402;4505:26905)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 31.38 * fem, 0 * fem),
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // homeWdm (I4511:32402;4505:26905;4504:26141)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                    width: 26 * fem,
                    height: 26 * fem,
                    child: Image.asset(
                      'assets/ui/images/home.png',
                      width: 26 * fem,
                      height: 26 * fem,
                    ),
                  ),
                  Text(
                    // homedCb (I4511:32402;4505:26905;4504:26142)
                    'Home',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.1818181818 * ffem / fem,
                      color: Color(0xff2d72b3),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              // componentAiK (I4511:32402;4505:26912)
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    21.88 * fem, 0 * fem, 21.88 * fem, 0 * fem),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // calendarssd (I4511:32402;4505:26912;4504:26144)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      width: 26 * fem,
                      height: 26 * fem,
                      child: Image.asset(
                        'assets/ui/images/calendar-onw.png',
                        width: 26 * fem,
                        height: 26 * fem,
                      ),
                    ),
                    Text(
                      // homeuZR (I4511:32402;4505:26912;4504:26145)
                      'Reminder',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 11 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.1818181818 * ffem / fem,
                        color: Color(0xff2d72b3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              // componentqT5 (I4511:32402;4505:26919)
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    31.38 * fem, 0 * fem, 31.38 * fem, 0 * fem),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // listwm1 (I4511:32402;4505:26919;4504:26144)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      width: 26 * fem,
                      height: 26 * fem,
                      child: Image.asset(
                        'assets/ui/images/list.png',
                        width: 26 * fem,
                        height: 26 * fem,
                      ),
                    ),
                    Text(
                      // homeGHV (I4511:32402;4505:26919;4504:26145)
                      'Notes',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 11 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.1818181818 * ffem / fem,
                        color: Color(0xff2d72b3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              // component1Vy (I4511:32402;4505:26926)
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    29.88 * fem, 0 * fem, 29.88 * fem, 0 * fem),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // user1vsq (I4511:32402;4505:26926;4504:26144)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      width: 26 * fem,
                      height: 26 * fem,
                      child: Image.asset(
                        'assets/ui/images/user-1.png',
                        width: 26 * fem,
                        height: 26 * fem,
                      ),
                    ),
                    Text(
                      // homeqzo (I4511:32402;4505:26926;4504:26145)
                      'Profile',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 11 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.1818181818 * ffem / fem,
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
    );
  }
}
