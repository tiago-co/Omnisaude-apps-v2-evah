import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/new_diagnosis/widgets/diagnosis_content.dart';

class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          // diagnosis6Nb (5103:25037)
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // autogroupegq5X1y (MYq7mKT7mgGJepXLwyeGq5)

                height: 32 * fem,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diagnosis',
                      style: TextStyle(
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.2999999306 * ffem / fem,
                        color: Color(0xff1a1c22),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffededf1)),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'This month',
                              style: TextStyle(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.4000000272 * ffem / fem,
                                color: Color(0xff1a1c22),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DefaultTabController(
                length: 2,
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xff2D73B3),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TabBar(
                          dividerColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 1,
                          indicatorColor: Color(0xff2D73B3),
                          isScrollable: true,
                          tabs: [
                            Tab(
                              child: Text(
                                'Ativo',
                                style: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238 * ffem / fem,
                                  color: Color(0xff2d72b3),
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Inativo',
                                style: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238 * ffem / fem,
                                  color: Color(0xff2d72b3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: DiagnosisContent(),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   // autogroupqhkbjhh (MYq84eHao8EJ4h9Cy9qHkB)
              //   padding: EdgeInsets.fromLTRB(20 * fem, 12 * fem, 20 * fem, 7 * fem),
              //   width: double.infinity,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         // diagnosis4EB (5103:27837)
              //         margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
              //         padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           color: Color(0xfff1f8fd),
              //           borderRadius: BorderRadius.circular(12 * fem),
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               // frame625xKZ (5103:27842)
              //               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
              //               padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Color(0xfff1f8fd)),
              //                 color: Color(0xffffffff),
              //                 borderRadius: BorderRadius.circular(12 * fem),
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     // autogroupvvo9ey5 (MYq8KoWzSeCY3qBazBVvo9)
              //                     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 9 * fem),
              //                     width: double.infinity,
              //                     height: 28 * fem,
              //                     child: Row(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Container(
              //                           // influenzaseasonalarj (5103:27953)
              //                           margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 75 * fem, 0 * fem),
              //                           child: Text(
              //                             'Influenza seasonal',
              //                             style: TextStyle(
              //                               fontSize: 18 * ffem,
              //                               fontWeight: FontWeight.w500,
              //                               height: 1.5 * ffem / fem,
              //                               color: Color(0xff1a1c22),
              //                             ),
              //                           ),
              //                         ),
              //                         Container(
              //                           // statusHm9 (5304:32311)
              //                           width: 67 * fem,
              //                           height: double.infinity,
              //                           decoration: BoxDecoration(
              //                             color: Color(0xffecf9f6),
              //                             borderRadius: BorderRadius.circular(40 * fem),
              //                           ),
              //                           child: Center(
              //                             child: Text(
              //                               'Active',
              //                               style: TextStyle(
              //                                 fontSize: 14 * ffem,
              //                                 fontWeight: FontWeight.w500,
              //                                 height: 1.4000000272 * ffem / fem,
              //                                 color: Color(0xff47bec1),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Container(
              //                     // frame536NXh (5103:27843)
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           // joomoraisvJK (5103:27844)
              //                           'João Morais',
              //                           style: TextStyle(
              //                             fontSize: 16 * ffem,
              //                             fontWeight: FontWeight.w500,
              //                             height: 1.6000000238 * ffem / fem,
              //                             color: Color(0xff1a1c22),
              //                           ),
              //                         ),
              //                         Text(
              //                           // gynecologyandobstetrics383 (5103:27846)
              //                           'Gynecology and obstetrics',
              //                           style: TextStyle(
              //                             fontSize: 14 * ffem,
              //                             fontWeight: FontWeight.w400,
              //                             height: 1.4000000272 * ffem / fem,
              //                             color: Color(0xff52576a),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Container(
              //               // frame1645xko (5103:27952)
              //               margin: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 39 * fem, 0 * fem),
              //               width: double.infinity,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     // frame537Vkj (5103:27838)
              //                     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
              //                     width: double.infinity,
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           // doctorsnote31Z (5103:27839)
              //                           'Doctor’s note',
              //                           style: TextStyle(
              //                             fontSize: 16 * ffem,
              //                             fontWeight: FontWeight.w500,
              //                             height: 1.6000000238 * ffem / fem,
              //                             color: Color(0xff1a1c22),
              //                           ),
              //                         ),
              //                         Text(
              //                           // preparealistofdiseasesofyourre (5103:27841)
              //                           'Prepare a list of diseases of your relatives.',
              //                           style: TextStyle(
              //                             fontSize: 14 * ffem,
              //                             fontWeight: FontWeight.w400,
              //                             height: 1.4000000272 * ffem / fem,
              //                             color: Color(0xff52576a),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   TextButton(
              //                     // buttonprimaryhro (5321:19847)
              //                     onPressed: () {},
              //                     style: TextButton.styleFrom(
              //                       padding: EdgeInsets.zero,
              //                     ),
              //                     child: Container(
              //                       width: 103 * fem,
              //                       height: 32 * fem,
              //                       child: Container(
              //                         // masterbuttonmasterSpP (I5321:19847;1301:14500)
              //                         padding: EdgeInsets.fromLTRB(12 * fem, 4 * fem, 12 * fem, 4 * fem),
              //                         width: double.infinity,
              //                         height: double.infinity,
              //                         decoration: BoxDecoration(
              //                           color: Color(0xffdfedfb),
              //                           borderRadius: BorderRadius.circular(40 * fem),
              //                         ),
              //                         child: Row(
              //                           crossAxisAlignment: CrossAxisAlignment.center,
              //                           children: [
              //                             Container(
              //                               // hyperlink9io (I5321:19847;1301:14500;1301:14377)
              //                               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 0 * fem),
              //                               width: 16 * fem,
              //                               height: 16 * fem,
              //                               child: Image.asset(
              //                                 'assets/ui/images/hyperlink-WxX.png',
              //                                 width: 16 * fem,
              //                                 height: 16 * fem,
              //                               ),
              //                             ),
              //                             Center(
              //                               // textUFH (I5321:19847;1301:14500;1301:14378)
              //                               child: Text(
              //                                 'Receipts',
              //                                 textAlign: TextAlign.center,
              //                                 style: TextStyle(
              //                                   fontSize: 14 * ffem,
              //                                   fontWeight: FontWeight.w600,
              //                                   height: 1.7142857143 * ffem / fem,
              //                                   color: Color(0xff2d72b3),
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         // diagnosisbKu (5103:27954)
              //         margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 38 * fem),
              //         padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           color: Color(0xfff1f8fd),
              //           borderRadius: BorderRadius.circular(12 * fem),
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               // frame6256Gf (5103:27955)
              //               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
              //               padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Color(0xfff1f8fd)),
              //                 color: Color(0xffffffff),
              //                 borderRadius: BorderRadius.circular(12 * fem),
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     // autogrouplrnxBJ7 (MYq8phrVusgQw6CJKzLRNX)
              //                     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 9 * fem),
              //                     width: double.infinity,
              //                     height: 28 * fem,
              //                     child: Row(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Container(
              //                           // commoncoldHrw (5103:27956)
              //                           margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 116 * fem, 0 * fem),
              //                           child: Text(
              //                             'Common cold',
              //                             style: TextStyle(
              //                               fontSize: 18 * ffem,
              //                               fontWeight: FontWeight.w500,
              //                               height: 1.5 * ffem / fem,
              //                               color: Color(0xff1a1c22),
              //                             ),
              //                           ),
              //                         ),
              //                         Container(
              //                           // statusCyu (5304:32316)
              //                           width: 67 * fem,
              //                           height: double.infinity,
              //                           decoration: BoxDecoration(
              //                             color: Color(0xffecf9f6),
              //                             borderRadius: BorderRadius.circular(40 * fem),
              //                           ),
              //                           child: Center(
              //                             child: Text(
              //                               'Active',
              //                               style: TextStyle(
              //                                 fontSize: 14 * ffem,
              //                                 fontWeight: FontWeight.w500,
              //                                 height: 1.4000000272 * ffem / fem,
              //                                 color: Color(0xff47bec1),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   Container(
              //                     // frame536trj (5103:27958)
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           // gabrielasolizT99 (5103:27959)
              //                           'Gabriela Soliz',
              //                           style: TextStyle(
              //                             fontSize: 16 * ffem,
              //                             fontWeight: FontWeight.w500,
              //                             height: 1.6000000238 * ffem / fem,
              //                             color: Color(0xff1a1c22),
              //                           ),
              //                         ),
              //                         Text(
              //                           // neurologistQ4P (5103:27961)
              //                           'Neurologist',
              //                           style: TextStyle(
              //                             fontSize: 14 * ffem,
              //                             fontWeight: FontWeight.w400,
              //                             height: 1.4000000272 * ffem / fem,
              //                             color: Color(0xff52576a),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Container(
              //               // frame1645YRV (5103:27962)
              //               margin: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 39 * fem, 0 * fem),
              //               width: double.infinity,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Container(
              //                     // frame537tET (5103:27963)
              //                     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
              //                     width: double.infinity,
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           // doctorsnoteEJK (5103:27964)
              //                           'Doctor’s note',
              //                           style: TextStyle(
              //                             fontSize: 16 * ffem,
              //                             fontWeight: FontWeight.w500,
              //                             height: 1.6000000238 * ffem / fem,
              //                             color: Color(0xff1a1c22),
              //                           ),
              //                         ),
              //                         Text(
              //                           // preparealistofdiseasesofyourre (5103:27966)
              //                           'Prepare a list of diseases of your relatives.',
              //                           style: TextStyle(
              //                             fontSize: 14 * ffem,
              //                             fontWeight: FontWeight.w400,
              //                             height: 1.4000000272 * ffem / fem,
              //                             color: Color(0xff52576a),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   TextButton(
              //                     // buttonprimary77D (5321:19865)
              //                     onPressed: () {},
              //                     style: TextButton.styleFrom(
              //                       padding: EdgeInsets.zero,
              //                     ),
              //                     child: Container(
              //                       width: 103 * fem,
              //                       height: 32 * fem,
              //                       child: Container(
              //                         // masterbuttonmasterr4o (I5321:19865;1301:14500)
              //                         padding: EdgeInsets.fromLTRB(12 * fem, 4 * fem, 12 * fem, 4 * fem),
              //                         width: double.infinity,
              //                         height: double.infinity,
              //                         decoration: BoxDecoration(
              //                           color: Color(0xffdfedfb),
              //                           borderRadius: BorderRadius.circular(40 * fem),
              //                         ),
              //                         child: Row(
              //                           crossAxisAlignment: CrossAxisAlignment.center,
              //                           children: [
              //                             Container(
              //                               // hyperlinkxtX (I5321:19865;1301:14500;1301:14377)
              //                               margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 0 * fem),
              //                               width: 16 * fem,
              //                               height: 16 * fem,
              //                               child: Image.asset(
              //                                 'assets/ui/images/hyperlink-Trw.png',
              //                                 width: 16 * fem,
              //                                 height: 16 * fem,
              //                               ),
              //                             ),
              //                             Center(
              //                               // text5CT (I5321:19865;1301:14500;1301:14378)
              //                               child: Text(
              //                                 'Receipts',
              //                                 textAlign: TextAlign.center,
              //                                 style: TextStyle(
              //                                   fontSize: 14 * ffem,
              //                                   fontWeight: FontWeight.w600,
              //                                   height: 1.7142857143 * ffem / fem,
              //                                   color: Color(0xff2d72b3),
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
