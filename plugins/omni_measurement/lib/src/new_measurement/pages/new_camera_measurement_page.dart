import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/loading_mode_camera_widget.dart';
import 'package:omni_measurement_labels/labels.dart';

// ignore: must_be_immutable
class NewCameraMeasurementPage extends StatefulWidget {
  final PageController pageController;

  const NewCameraMeasurementPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<NewCameraMeasurementPage> createState() =>
      _NewCameraMeasurementPageState();
}

class _NewCameraMeasurementPageState extends State<NewCameraMeasurementPage> {
  final NewMeasurementStore store = Modular.get<NewMeasurementStore>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TripleBuilder<NewMeasurementStore, DioError, MeasurementModel>(
        store: store,
        builder: (_, triple) {
          if (triple.event == TripleEvent.error) {
            Helpers.showDialog(
              context,
              RequestErrorWidget(
                error: triple.error,
                onPressed: () {
                  store.setCurrentMeasure('null');
                  store.counterPage = store.counterPage - 2;
                  store.counterButton--;
                  store.updateForm(store.state);
                  Modular.to.pop();
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                buttonText: MeasurementLabels.close,
              ),
              showClose: true,
            );
          }
          if (store.isLoading) {
            return const LoadingModeCameraWidget();
          } else if (store.state.currentMeasure != '-1') {
            return measureReturn;
          } else {
            return notIdentifiedMeasure;
          }
        },
      ),
    );
  }

  Widget get measureReturn {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.iconAlert,
          package: AssetsPackage.omniGeneral,
          color: Colors.amber.withOpacity(0.8),
          height: 75,
        ),
        const SizedBox(height: 10),
        Text(
          MeasurementLabels.newCameraMeasurementConfirm,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              store.state.measurementType!.asset,
              package: 'omni_measurement',
              color: Theme.of(context).primaryColor,
              height: 50,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.state.measurementType!.label,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      store.state.currentMeasure!,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: 35,
                          ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      store.state.measurementType!.deviceMeasurementType,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        RoundedButtonWidget(
          text: MeasurementLabels.newCameraMeasurementTryAgain,
          borderRadius: 25,
          onPressed: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
            store.setCurrentMeasure('null');
            store.counterPage = store.counterPage - 2;
            store.counterButton--;
            store.updateForm(store.state);
          },
          buttonType: DefaultButtonType.outline,
        ),
        const SizedBox(height: 15),
        // Text(
        //   'ou',
        //   textAlign: TextAlign.center,
        //   style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
        // ),
        // const SizedBox(height: 15),
      ],
    );
  }

  Widget get notIdentifiedMeasure {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          MeasurementLabels.newCameraMeasurementOps,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
        ),
        const SizedBox(height: 20),
        Stack(
          children: [
            SvgPicture.asset(
              'assets/error_camera/error_camera_base.svg',
              package: 'omni_measurement',
              height: 175,
            ),
            SvgPicture.asset(
              'assets/error_camera/error_camera_color.svg',
              package: 'omni_measurement',
              color: Theme.of(context).primaryColor,
              height: 175,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          MeasurementLabels.newCameraMeasurementSomethingWrong,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 15),
        Text(
          MeasurementLabels.newCameraMeasurementPleaseTryAgain,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
