import 'package:flutter/material.dart';

class DiagnosisItem extends StatelessWidget {
  const DiagnosisItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xfff1f8fd)),
        color: Color(0xffF2F8FD),
        borderRadius: BorderRadius.circular(12 * fem),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(1),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // influenzaseasonalarj (5103:27953)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            'Influenza seasonal',
                            style: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffecf9f6),
                            borderRadius: BorderRadius.circular(40 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Ativo',
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
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // joomoraisvJK (5103:27844)
                          'João Morais',
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.6000000238 * ffem / fem,
                            color: Color(0xff1a1c22),
                          ),
                        ),
                        Text(
                          // gynecologyandobstetrics383 (5103:27846)
                          'Gynecology and obstetrics',
                          style: TextStyle(
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
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
              16,
              0,
              0,
              0,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    0 * fem,
                    0 * fem,
                    0 * fem,
                    16 * fem,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doctor’s note',
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.6000000238 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                      Text(
                        // preparealistofdiseasesofyourre (5103:27841)
                        'Prepare a list of diseases of your relatives.',
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.4000000272 * ffem / fem,
                          color: Color(0xff52576a),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  // buttonprimaryhro (5321:19847)
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    // masterbuttonmasterSpP (I5321:19847;1301:14500)
                    padding: EdgeInsets.fromLTRB(12 * fem, 4 * fem, 12 * fem, 4 * fem),
                    decoration: BoxDecoration(
                      color: Color(0xffdfedfb),
                      borderRadius: BorderRadius.circular(40 * fem),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            0 * fem,
                            0 * fem,
                            4 * fem,
                            0 * fem,
                          ),
                          child: const Icon(Icons.link),
                        ),
                        Center(
                          child: Text(
                            'Receipts',
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
