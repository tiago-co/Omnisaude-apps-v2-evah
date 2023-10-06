import 'package:flutter/material.dart';

class ConsultationHeader extends StatelessWidget {
  const ConsultationHeader();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // datestatusxD5 (I4511:32375;4508:27494)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),

      height: 28 * fem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // frame1510ftB (I4511:32375;3902:11778)
            margin: EdgeInsets.fromLTRB(0 * fem, 4 * fem, 0 * fem, 4 * fem),
            height: double.infinity,
            child: Row(
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
                'Aprovado',
                style: TextStyle(
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
