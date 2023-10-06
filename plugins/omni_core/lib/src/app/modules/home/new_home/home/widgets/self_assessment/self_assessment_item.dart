import 'package:flutter/material.dart';

class SelfAssessmentItem extends StatelessWidget {
  const SelfAssessmentItem();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // group46jsM (4511:32380)
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
        padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
        // component53d9 (4511:32381)

        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffededf1)),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12 * fem),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        // S1m (I4511:32375;3902:11781)
                        '27/04',
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4000000272 * ffem / fem,
                          color: Color(0xff878da0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        // amETR (I4511:32375;3902:11784)
                        '11:57am',
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4000000272 * ffem / fem,
                          color: Color(0xff878da0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 32 * fem,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xffecf9f6),
                      borderRadius: BorderRadius.circular(16 * fem),
                    ),
                    child: Center(
                      child: Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.6000000238 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    // acuteheadachen8o (4511:32396)
                    'Dor de cabeça aguda',
                    style: TextStyle(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.6000000238 * ffem / fem,
                      color: Color(0xff1a1c22),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
