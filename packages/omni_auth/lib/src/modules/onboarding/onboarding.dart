import 'package:flutter/material.dart';
import 'package:omni_auth/src/modules/onboarding/widgets/onboard_1.dart';
import 'package:omni_auth/src/modules/onboarding/widgets/onboard_2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatelessWidget {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                Onboard1(),
                Onboard2(),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 2,
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            // buttonprimaryU9M (4511:30440)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 60 * fem),
            child: TextButton(
              onPressed: () {
                if (_controller.page?.toInt() == 0) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56 * fem,
                child: Container(
                  // masterbuttonmasterBZZ (I4511:30440;19:7388)
                  padding: EdgeInsets.fromLTRB(
                      128 * fem, 16 * fem, 134.5 * fem, 16 * fem),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff2d72b3),
                    borderRadius: BorderRadius.circular(60 * fem),
                  ),
                  child: Container(
                    // autogroupdwo5VKM (MYmEasVSBSEkWkj3SHdwo5)
                    padding: EdgeInsets.fromLTRB(
                        6.5 * fem, 0 * fem, 0 * fem, 0 * fem),
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        'Let\'s go!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.5 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
