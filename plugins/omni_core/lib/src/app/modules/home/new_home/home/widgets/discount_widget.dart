import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class DiscountsWidget extends StatelessWidget {
  const DiscountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // frame1538iCP (4511:32333)

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // group49f7d (4511:32334)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * fem),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // discountsBrf (4511:32335)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: Text(
                    'Discounts',
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
                  // masterbuttonmasteri5u (4902:28309)
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 24 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Container(
                      // boxdCs (I4902:28309;21:5984)

                      height: double.infinity,
                      child: Container(
                        // autogroupxjf5nrT (MYo2hYg9nTYQaMZ1aYXjf5)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0 * fem),

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
            // frame1576fQT (4511:32337)
            height: 88 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // frame1573oFm (4511:32338)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 24 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          2.83 * fem, 0 * fem, 2.83 * fem, 0 * fem),
                      width: 95.67 * fem,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // group59V8b (4511:32339)
                            margin: EdgeInsets.fromLTRB(
                                18 * fem, 0 * fem, 18 * fem, 8 * fem),
                            padding: EdgeInsets.fromLTRB(
                                13 * fem, 13 * fem, 13 * fem, 13 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffed8181),
                              borderRadius: BorderRadius.circular(27 * fem),
                            ),
                            child: Center(
                              // firstaidbagbhR (4511:32341)
                              child: SizedBox(
                                width: 28 * fem,
                                height: 28 * fem,
                                child: Image.asset(
                                  'assets/ui/images/first-aid-bag.png',
                                  width: 28 * fem,
                                  height: 28 * fem,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            // pharmaciesvUo (4511:32342)
                            'Pharmacies',
                            textAlign: TextAlign.center,
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
                ),
                Container(
                  // frame1574rdM (4511:32343)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 24 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          20.83 * fem, 0 * fem, 20.83 * fem, 0 * fem),
                      width: 95.67 * fem,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // group598Ky (4511:32344)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 8 * fem),
                            padding: EdgeInsets.fromLTRB(
                                13 * fem, 12 * fem, 13 * fem, 14 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff47bec1),
                              borderRadius: BorderRadius.circular(27 * fem),
                            ),
                            child: Center(
                              // pilldnX (4511:32346)
                              child: SizedBox(
                                width: 28 * fem,
                                height: 28 * fem,
                                child: Image.asset(
                                  'assets/ui/images/pill-NrK.png',
                                  width: 28 * fem,
                                  height: 28 * fem,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            // examsZgB (4511:32347)
                            'Exams',
                            textAlign: TextAlign.center,
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
                ),
                TextButton(
                  // frame1575hXV (5303:17815)
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        20.83 * fem, 0 * fem, 20.83 * fem, 0 * fem),
                    width: 95.67 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // group59QRu (5303:17816)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          padding: EdgeInsets.fromLTRB(
                              13 * fem, 12 * fem, 13 * fem, 14 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xff949cb7),
                            borderRadius: BorderRadius.circular(27 * fem),
                          ),
                          child: Center(
                            // medicalcrossihV (5303:17818)
                            child: SizedBox(
                              width: 28 * fem,
                              height: 28 * fem,
                              child: Image.asset(
                                'assets/ui/images/medical-cross.png',
                                width: 28 * fem,
                                height: 28 * fem,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          // other3Dy (5303:17819)
                          'Other',
                          textAlign: TextAlign.center,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
