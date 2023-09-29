import 'package:flutter/material.dart';
import 'package:myapp/ui/home/widgets/self_assessment/self_assessment_item.dart';
import 'package:myapp/utils.dart';

class SelfAssessmentWidget extends StatelessWidget {
  const SelfAssessmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // group43zcw (4511:32377)
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // selfassessment8DM (4511:32378)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  'Self-assessment',
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
                // buttonprimary35R (4902:28271)
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 104 * fem,
                  height: 24 * fem,
                  child: Container(
                    // masterbuttonmastern31 (I4902:28271;21:5442)
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Container(
                      // boxL4X (I4902:28271;21:5442;21:5984)
                      width: double.infinity,
                      height: double.infinity,
                      child: Container(
                        // autogroup3gw1g8P (MYo4ipe5LZmZyeWPQf3gw1)
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
              ),
            ],
          ),
        ),
        const SelfAssessmentItem()
      ],
    );
  }
}
