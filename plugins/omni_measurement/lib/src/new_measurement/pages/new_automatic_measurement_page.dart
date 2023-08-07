import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/bluetooth_off_state_widget.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/list_found_devices_widget.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/loading_get_measure_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';

class NewAutomaticMeasurementPage extends StatefulWidget {
  final PageController pageController;
  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  NewAutomaticMeasurementPage({
    Key? key,
    required this.pageController,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  State<NewAutomaticMeasurementPage> createState() =>
      _NewAutomaticMeasurementPageState();
}

class _NewAutomaticMeasurementPageState
    extends State<NewAutomaticMeasurementPage> {
  final NewMeasurementStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothAdapterState>(
      stream: FlutterBluePlus.adapterState,
      initialData: BluetoothAdapterState.unknown,
      builder: (c, snapshot) {
        final state = snapshot.data;
        if (state == BluetoothAdapterState.on) {
          return Expanded(
            child:
                TripleBuilder<NewMeasurementStore, DioError, MeasurementModel>(
              store: store,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const Center(
                    child: LoadingGetMeasureWidget(),
                  );
                } else {
                  return ListFoundDevicesWidget(
                    pageController: widget.pageController,
                    scaffoldKey: widget.scaffoldKey,
                  );
                }
              },
            ),
          );
        } else {
          return BluetoothOffStateWidget(
            state: state,
          );
        }
      },
    );
  }
}
