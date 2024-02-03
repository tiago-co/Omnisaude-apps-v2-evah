import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

class DiscountsWidget extends StatelessWidget {
  const DiscountsWidget();

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

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
                Text(
                  'Descontos',
                  style: TextStyle(
                    fontSize: 22 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2999999306 * ffem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Modular.to.pushNamed(
                      '/newHome/discounts/discounts',
                      arguments: {
                        'moduleName': 'Desconto em Farmácias',
                        'categoryParam': '19',
                      },
                    );
                  },
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
                        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),

                        height: double.infinity,
                        child: Center(
                          child: Center(
                            child: Text(
                              'Ver tudo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w500,
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 88 * fem,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      '/newHome/discounts/cupons',
                      arguments: {
                        // 'moduleName': 'Desconto em Farmácia',
                        'categoryParam': '19',
                        'organizationId': 0,
                        'moduleName': 'Desconto em Farmácias',
                        'coverImage': '',
                        'couponRescueType': 'physical',
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 54 * fem,
                        height: 54 * fem,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xffed8181),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: AspectRatio(
                              aspectRatio: fem > 2 ? 2 : fem + 0.5,
                              child: SvgPicture.asset(
                                Assets.pillIcon,
                                package: AssetsPackage.omniCore,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        // pharmaciesvUo (4511:32342)
                        'Farmácias',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6000000238 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   // frame1574rdM (4511:32343)
                //   margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                //   child: TextButton(
                //     onPressed: () {},
                //     style: TextButton.styleFrom(
                //       padding: EdgeInsets.zero,
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Container(
                //           // margin: const EdgeInsets.all(12.0),
                //           width: 54,
                //           height: 54,
                //           child: CircleAvatar(
                //             backgroundColor: Color(0xff47bec1),
                //             // pilldnX (4511:32346)
                //             child: SvgPicture.asset(
                //               Assets.firstAidBagIcon,
                //               package: AssetsPackage.omniCore,
                //             ),
                //           ),
                //         ),
                //         Text(
                //           // examsZgB (4511:32347)
                //           'Exames',
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             fontSize: 16 * ffem,
                //             fontWeight: FontWeight.w600,
                //             height: 1.6000000238 * ffem / fem,
                //             color: Color(0xff1a1c22),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  width: 32,
                ),
                Container(
                  // frame1573oFm (4511:32338)
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: TextButton(
                    onPressed: () {
                      Modular.to.pushNamed(
                        '/newHome/discounts/cupons',
                        arguments: {
                          // 'moduleName': 'Desconto em Farmácia',
                          'categoryParam': '247',
                          'organizationId': 0,
                          'moduleName': 'Descontos em Exames',
                          'coverImage': '',
                          'couponRescueType': 'online',
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // margin: const EdgeInsets.all(12.0),
                          width: 54,
                          height: 54,
                          child: CircleAvatar(
                            backgroundColor: Color(0xff48BEC2),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              // firstaidbagbhR (4511:32341)
                              child: SvgPicture.asset(
                                Assets.examsNewIcon,
                                package: AssetsPackage.omniCore,
                                color: Colors.white,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          // pharmaciesvUo (4511:32342)
                          'Exames',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.6000000238 * ffem / fem,
                            color: Color(0xff1a1c22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                TextButton(
                  // frame1575hXV (5303:17815)
                  onPressed: () {
                    Modular.to.pushNamed(
                      '/newHome/discounts/cupons',
                      arguments: {
                        // 'moduleName': 'Desconto em Farmácia',
                        'categoryParam': '',
                        'organizationId': 0,
                        'moduleName': 'Outros descontos',
                        'coverImage': '',
                        'couponRescueType': 'online',
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 54 * fem,
                        height: 54 * fem,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff949DB8),
                          child: AspectRatio(
                            aspectRatio: fem > 2 ? 2 : fem + 0.5,
                            child: SvgPicture.asset(
                              Assets.medicalCrossIcon,
                              package: AssetsPackage.omniCore,
                              color: Colors.white,
                              width: 28 * fem,
                              height: 28 * fem,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        // examsZgB (4511:32347)
                        'Outros',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.6000000238 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
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
