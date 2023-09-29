import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({required this.image, required this.title, super.key});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return TextButton(
      // frame15282r3 (4701:10680)
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 3.45 * fem, 0 * fem),
        height: 100,
        width: 140,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color(0xffedf5fc),
          borderRadius: BorderRadius.circular(12 * fem),
        ),
        child: OverflowBox(
          child: Column(
            children: [
              Container(
                // consultationshhH (4701:10682)
                margin: EdgeInsets.fromLTRB(
                    0 * fem, 0 * fem, 0.55 * fem, 4.77 * fem),
                child: Text(
                  'Consultations',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.6000000238 * ffem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              ClipRect(
                child: Container(
                  // mediconahora011hy (4701:10683)
                  padding: EdgeInsets.fromLTRB(
                      0 * fem, 3.22 * fem, 0 * fem, 0 * fem),
                  width: 88.97 * fem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // autogroupj8vbKyZ (MYo2Ne3zNHtStdyT22j8vB)
                        margin: EdgeInsets.fromLTRB(
                            0.58 * fem, 0 * fem, 0.54 * fem, 2.5 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectorG1d (4701:10684)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0.98 * fem, 0.71 * fem),
                              width: 27.22 * fem,
                              height: 33.43 * fem,
                              child: Image.asset(
                                'assets/ui/images/vector-uF5.png',
                                width: 27.22 * fem,
                                height: 33.43 * fem,
                              ),
                            ),
                            ClipRect(
                              child: Container(
                                // mediconahora02kxP (4701:10687)
                                width: 32.65 * fem,
                                height: 34.43 * fem,
                                child: Image.asset(
                                  'assets/ui/images/medico-na-hora-02-MB5.png',
                                  width: 32.65 * fem,
                                  height: 34.43 * fem,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // group5zf (4701:10685)
                        width: 63.03 * fem,
                        height: 28.95 * fem,
                        child: Image.asset(
                          'assets/ui/images/group-DyR.png',
                          width: 63.03 * fem,
                          height: 28.95 * fem,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
