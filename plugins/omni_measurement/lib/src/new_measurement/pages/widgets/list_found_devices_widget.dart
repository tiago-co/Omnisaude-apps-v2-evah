import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/device_list_item_widget.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/no_found_device_bluetooth_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/bluetooth_scan_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/empty_list_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class ListFoundDevicesWidget extends StatefulWidget {
  final PageController pageController;
  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  ListFoundDevicesWidget({
    Key? key,
    required this.pageController,
    this.scaffoldKey,
  }) : super(key: key);
  @override
  State<ListFoundDevicesWidget> createState() => _ListFoundDevicesWidgetState();
}

class _ListFoundDevicesWidgetState extends State<ListFoundDevicesWidget> {
  final NewMeasurementStore _store = Modular.get();
  final BluetoothScanStore _bluetoothStore = Modular.get();
  final EmptyListStore _emptyListStore = Modular.get();

  @override
  void initState() {
    test();

    super.initState();
  }

  Future<void> test() async {
    await FlutterBluePlus.isOn.then(
      (isOn) {
        if (isOn) {
          _getDevices();
        }
      },
    );
  }

  Future<void> _getDevices() async {
    await _bluetoothStore.startScanningDevices(_store.state.measurementType!);
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<BluetoothScanStore, Exception, bool>(
      store: _bluetoothStore,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const ScanDevicesBluetoothWidget(
            text: MeasurementLabels.listFoundDevicesSearching,
          );
        } else {
          return StreamBuilder<void>(
            stream: Stream.periodic(
              const Duration(seconds: 3),
            ).asyncMap(
              (_) async {
                await _bluetoothStore.startScanningDevicesStream(
                  _store.state.measurementType!,
                );
              },
            ),
            builder: (context, snapshot) {
              return TripleBuilder<EmptyListStore, Exception, bool>(
                store: _emptyListStore,
                builder: (_, tripleEmpty) {
                  if (tripleEmpty.state) {
                    return NoFoundDeviceBluettohWidget(
                      text: 'Nenhum dispostivo encontrado',
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var device
                                    in _bluetoothStore.connectedDevicesList)
                                  DeviceListItemWidget(
                                    device: device,
                                    measurementType:
                                        _store.state.measurementType,
                                    onTap: () async {
                                      await _store
                                          .readConnectedDevices(
                                        device,
                                        _store.state.measurementType!,
                                      )
                                          .then(
                                        (value) {
                                          _store.categoryStep = 3;
                                          _store.counterButton++;
                                          _store.updateForm(_store.state);
                                          widget.pageController.nextPage(
                                            duration: const Duration(
                                              milliseconds: 250,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                      ).catchError(
                                        (error) {
                                          Helpers.showDialog(
                                            widget.scaffoldKey!.currentContext!,
                                            RequestErrorWidget(
                                              message: MeasurementLabels
                                                  .listFoundDevicesError,
                                              onPressed: () => Modular.to.pop(),
                                              buttonText:
                                                  MeasurementLabels.close,
                                            ),
                                            showClose: true,
                                          );
                                        },
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var device
                                    in _bluetoothStore.scannedDevicesList)
                                  DeviceListItemWidget(
                                    device: device.device,
                                    measurementType:
                                        _store.state.measurementType,
                                    onTap: () async {
                                      await _store
                                          .readUnconnectedDevices(
                                        device.device,
                                        _store.state.measurementType!,
                                      )
                                          .then(
                                        (value) {
                                          _store.categoryStep = 3;
                                          _store.counterButton++;
                                          _store.updateForm(_store.state);
                                          widget.pageController.nextPage(
                                            duration: const Duration(
                                              milliseconds: 250,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                      ).catchError(
                                        (error) {
                                          Helpers.showDialog(
                                            widget.scaffoldKey!.currentContext!,
                                            RequestErrorWidget(
                                              message: MeasurementLabels
                                                  .newMeasurementError,
                                              onPressed: () => Modular.to.pop(),
                                              buttonText:
                                                  MeasurementLabels.close,
                                            ),
                                            showClose: true,
                                          );
                                        },
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
