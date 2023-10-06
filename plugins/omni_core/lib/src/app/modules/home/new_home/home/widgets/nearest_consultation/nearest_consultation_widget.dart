import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/nearest_consultation/consultation_header.dart';

class NearestConsultationWidget extends StatelessWidget {
  const NearestConsultationWidget();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
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
                    'Próximas consultas',
                    style: TextStyle(
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
                    height: 24 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Text(
                      'Ver tudo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.5 * ffem / fem,
                        color: Color(0xff52576a),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            // consultationziB (4511:32375)

            decoration: BoxDecoration(
              color: Color(0xfff1f8fd),
              borderRadius: BorderRadius.circular(12 * fem),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      16 * fem, 16 * fem, 16 * fem, 16 * fem),
                  height: 119 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfff1f8fd)),
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(12 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ConsultationHeader(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // joomorais1cb (I4511:32375;3902:11775)
                            'João Morais',
                            style: TextStyle(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                          Text(
                            // gynecologyandobstetricsMRZ (I4511:32375;3902:11777)
                            'Gincologista e obstreta',
                            style: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.4000000272 * ffem / fem,
                              color: Color(0xff52576a),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notas do Dr.',
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.6000000238 * ffem / fem,
                                color: Color(0xff1a1c22),
                              ),
                            ),
                            Text(
                              'Prepare uma lista de doenças de seus parentes.',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                12 * fem, 4 * fem, 12 * fem, 4 * fem),
                            decoration: BoxDecoration(
                              color: Color(0xffdfedfb),
                              borderRadius: BorderRadius.circular(40 * fem),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.link,
                                  size: 16,
                                  color: Color(0xff2d72b3),
                                ),
                                const SizedBox(width: 4),
                                Center(
                                  // textAHD (I4511:32375;5321:17959;1301:14500;1301:14378)
                                  child: Text(
                                    'Receitas',
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 4,
                            ),
                            height: 32 * fem,
                            decoration: BoxDecoration(
                              color: Color(0xff2d72b3),
                              borderRadius: BorderRadius.circular(40 * fem),
                            ),
                            child: Text(
                              'Reagendar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.7142857143 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
