import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/new_measurement/pages/new_automatic_measurement_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/new_camera_measurement_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/new_manual_measurement_page.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';

class ReceiveNewMeasurementPage extends StatefulWidget {
  final PageController pageController;
  final GlobalKey formKey;
  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  ReceiveNewMeasurementPage({
    Key? key,
    required this.pageController,
    required this.formKey,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  _ReceiveNewMeasurementPageState createState() =>
      _ReceiveNewMeasurementPageState();
}

class _ReceiveNewMeasurementPageState extends State<ReceiveNewMeasurementPage> {
  final NewMeasurementStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          store.state.measurementMode == MeasurementMode.automatic
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
      children: [
        // const SizedBox(height: 20),
        if (store.state.measurementMode == MeasurementMode.automatic)
          NewAutomaticMeasurementPage(
            pageController: widget.pageController,
            scaffoldKey: widget.scaffoldKey,
          )
        else if (store.state.measurementMode == MeasurementMode.camera)
          NewCameraMeasurementPage(
            pageController: widget.pageController,
          )
        else if (store.state.measurementMode == MeasurementMode.manual)
          NewManualMeasurementPage(
            pageController: widget.pageController,
            formKey: widget.formKey,
          )
      ],
    );
  }
}
