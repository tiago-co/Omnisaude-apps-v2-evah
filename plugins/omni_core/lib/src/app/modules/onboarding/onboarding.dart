import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/onboarding/widgets/onboard_1.dart';
import 'package:omni_core/src/app/modules/onboarding/widgets/onboard_2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;
    final double fem = MediaQuery.of(context).size.width / baseWidth;
    final double ffem = fem * 0.97;
    // final double he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20 * fem),
        child: Column(children: [
          Flexible(
            child: PageView(
              controller: _controller,
              children: const [
                Onboard1(),
                Onboard2(),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 24,
          // ),
          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: const WormEffect(
              dotWidth: 8,
              dotHeight: 8,
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth/newLogin');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              height: 56 * fem,
              decoration: BoxDecoration(
                color: const Color(0xff2d72b3),
                borderRadius: BorderRadius.circular(60 * fem),
              ),
              child: Center(
                child: Text(
                  'Começar',
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
        ]),
      ),
    );
  }
}
