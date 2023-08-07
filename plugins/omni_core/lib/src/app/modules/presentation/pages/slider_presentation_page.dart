import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/enums/presentation_enum.dart';
import 'package:omni_core/src/app/modules/presentation/pages/widgets/slider_dots_widget.dart';
import 'package:omni_core/src/app/modules/presentation/pages/widgets/slider_item_widget.dart';
import 'package:omni_core/src/app/modules/presentation/stores/slider_presentation_store.dart';
import 'package:omni_general/omni_general.dart' show BottomButtonWidget;
import 'package:presentation_labels/labels.dart';

class SliderPresentationPage extends StatefulWidget {
  const SliderPresentationPage({Key? key}) : super(key: key);

  @override
  _SliderPresentationPageState createState() => _SliderPresentationPageState();
}

class _SliderPresentationPageState extends State<SliderPresentationPage> {
  final SliderPresentationStore store = Modular.get();
  final CarouselController carouselController = CarouselController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SafeArea(
              child: CarouselSlider.builder(
                itemCount: 2,
                carouselController: carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.0,
                  disableCenter: true,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.decelerate,
                  onPageChanged: store.onChangeSliderSelected,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                ),
                itemBuilder: (_, index, realIndex) {
                  return _buildSliderItemWidget(index);
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          SliderDotsWidget(store: store),
          const SizedBox(height: 15),
        ],
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () {
          Modular.to.pushNamed('/presentation/letsGo');
        },
        text: PresentationLabels.sliderPresentationletsGo,
      ),
    );
  }

  Widget _buildSliderItemWidget(int index) {
    if (index == 0) {
      return const SliderItemWidget(
        title: PresentationLabels.sliderPresentationManagementTitle,
        text: PresentationLabels.sliderPresentationManagementText,
        type: PresentationType.management,
      );
    } else if (index == 1) {
      return const SliderItemWidget(
        title: PresentationLabels.sliderPresentationSchedulingTitle,
        text: PresentationLabels.sliderPresentationSchedulingText,
        type: PresentationType.scheduling,
      );
    } else if (index == 2) {
      return const SliderItemWidget(
        title: PresentationLabels.sliderPresentationVaccineTitle,
        text: PresentationLabels.sliderPresentationVaccineText,
        type: PresentationType.vaccine,
      );
    }
    // else if (index == 1) {
    //   return const SliderItemWidget(
    //     title: 'Acompanhe suas vacinas',
    //     text: 'Visualize sua carteira de vacinação em seu calendário.',
    //     type: PresentationType.vaccine,
    //   );
    // }
    return const SizedBox();
  }
}
