import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/enums/presentation_enum.dart';

import 'package:omni_core/src/app/modules/presentation/pages/widgets/slider_item_text_widget.dart';
import 'package:omni_core/src/app/modules/presentation/pages/widgets/slider_item_title_widget.dart';

class SliderItemWidget extends StatelessWidget {
  final String title;
  final String text;
  final PresentationType type;

  const SliderItemWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SliderItemTitleWidget(title: title),
          ),
        ),
        _buildPresentationImageWidget(context),
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SliderItemTextWidget(text: text),
          ),
        ),
      ],
    );
  }

  Widget _buildPresentationImageWidget(BuildContext context) {
    late final String base;
    late final String half;
    late final String front;

    switch (type) {
      case PresentationType.vaccine:
        base = Assets.vaccineBase;
        half = Assets.vaccine;
        front = Assets.vaccineFront;
        break;
      case PresentationType.scheduling:
        base = Assets.schedulingBasePresentation;
        half = Assets.schedulingPresentation;
        front = Assets.schedulingFrontPresentation;
        break;
      case PresentationType.management:
        base = Assets.managementBase;
        half = Assets.management;
        front = Assets.managementFront;
        break;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: [
          SvgPicture.asset(
            base,
            package: AssetsPackage.omniCore,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            height: MediaQuery.of(context).size.height / 2,
          ),
          SvgPicture.asset(
            half,
            package: AssetsPackage.omniCore,
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height / 2,
          ),
          SvgPicture.asset(
            front,
            package: AssetsPackage.omniCore,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ],
      ),
    );
  }
}
