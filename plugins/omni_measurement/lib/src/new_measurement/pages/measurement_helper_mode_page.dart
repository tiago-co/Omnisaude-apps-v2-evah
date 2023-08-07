import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementHelperModePage extends StatefulWidget {
  final PageController pageController;
  final Function(MeasurementModel, MeasurementMode) nextOrCreateMeasurement;

  const MeasurementHelperModePage({
    Key? key,
    required this.pageController,
    required this.nextOrCreateMeasurement,
  }) : super(key: key);

  @override
  State<MeasurementHelperModePage> createState() =>
      _MeasurementHelperModePageState();
}

class _MeasurementHelperModePageState extends State<MeasurementHelperModePage> {
  @override
  Widget build(BuildContext context) {
    final NewMeasurementStore store = Modular.get();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    store.state.measurementMode!.assetInstructionBase,
                    package: 'omni_measurement',
                    width: 150,
                  ),
                  SvgPicture.asset(
                    store.state.measurementMode!.assetInstructionColor,
                    package: 'omni_measurement',
                    color: Theme.of(context).primaryColor,
                    width: 150,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                MeasurementLabels.measurementHelperModeDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.065),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          store.state.measurementMode!.assetColorlOne,
                          color: Theme.of(context).primaryColor,
                          package: 'omni_measurement',
                          width: 55,
                        ),
                        SvgPicture.asset(
                          store.state.measurementMode!.assetBaselOne,
                          package: 'omni_measurement',
                          width: 55,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    flex: 8,
                    child: Text(
                      store.state.measurementMode == MeasurementMode.manual
                          ? '${store.state.measurementMode!.helpOne} '
                              '${store.state.measurementType!.pageTitle} e faça sua medição.'
                          : '${store.state.measurementMode!.helpOne}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          store.state.measurementMode!.assetColorlTwo,
                          color: Theme.of(context).primaryColor,
                          package: 'omni_measurement',
                          width: 55,
                        ),
                        SvgPicture.asset(
                          store.state.measurementMode!.assetBaseTwo,
                          package: 'omni_measurement',
                          width: 55,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 8,
                    child: Text(
                      store.state.measurementMode == MeasurementMode.automatic
                          ? '${store.state.measurementMode!.helpTwo} ${store.state.measurementType!.pageTitle} e faça sua medição.'
                          : '${store.state.measurementMode!.helpTwo}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          store.state.measurementMode!.assetColorlThree,
                          color: Theme.of(context).primaryColor,
                          package: 'omni_measurement',
                          width: 55,
                        ),
                        SvgPicture.asset(
                          store.state.measurementMode!.assetBaseThree,
                          package: 'omni_measurement',
                          width: 55,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 8,
                    child: Text(
                      store.state.measurementMode!.helpThree!,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
