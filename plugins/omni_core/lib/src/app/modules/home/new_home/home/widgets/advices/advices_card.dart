import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvicesCard extends StatefulWidget {
  const AdvicesCard({Key? key}) : super(key: key);

  @override
  State<AdvicesCard> createState() => _AdvicesCardState();
}

class _AdvicesCardState extends State<AdvicesCard> {
  final PageController _controller = PageController();

  final cards = [
    Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse('https://wa.me/5562998845801'),
          mode: LaunchMode.externalApplication,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                right: -70,
                top: -10,
                child: SizedBox(
                  // width: constraints.maxWidth,
                  height: 130,
                  child: AspectRatio(
                    aspectRatio: 3.5,
                    child: SvgPicture.asset(
                      Assets.whatsappAdvice,
                      package: AssetsPackage.omniCore,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dúvidas sobre saude\nda mulher?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Fale conosco pelo whatsapp',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    // Card(
    //   color: Colors.white,
    //   surfaceTintColor: Colors.white,
    //   clipBehavior: Clip.hardEdge,
    //   child: InkWell(
    //     onTap: () => launchUrl(
    //       Uri.parse(
    //           'https://api.whatsapp.com/send/?phone=556231002629&text=Ol%C3%A1%2C+sou+assinante+Evah+Sa%C3%BAde+e+queria+aproveitar+a+parceria&type=phone_number&app_absent=0'),
    //       mode: LaunchMode.externalApplication,
    //     ),
    //     child: SizedBox(
    //       width: double.maxFinite,
    //       child: Image.asset(
    //         Assets.ortoEsteticaAdvice,
    //         package: AssetsPackage.omniCore,
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //   ),
    // )
  ];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Timer.periodic(
    //     const Duration(milliseconds: 2850),
    //     (Timer t) {
    //       _controller.nextPage(
    //         duration: const Duration(milliseconds: 1000),
    //         curve: Curves.decelerate,
    //       );
    //     },
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 110, maxWidth: constraints.maxWidth),
          child: Column(
            children: [
              Flexible(
                child: PageView.builder(
                  controller: _controller,
                  padEnds: false,
                  itemCount: 1,
                  itemBuilder: (context, index) => cards[index % cards.length],
                ),
              ),
              // const SizedBox(
              //   height: 12,
              // ),
              // SmoothPageIndicator(
              //   controller: _controller,
              //   count: 2,
              //   effect: WormEffect(
              //     dotWidth: 8,
              //     dotHeight: 8,
              //     activeDotColor: Theme.of(context).primaryColor,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
