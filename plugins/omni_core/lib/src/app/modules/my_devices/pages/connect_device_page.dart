import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/widgets/item_list_device_widget.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/empty_devices_list_store.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/scan_new_devices_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

class ConnectDevicePage extends StatefulWidget {
  final MyDevicesStore myDevicesStore;
  const ConnectDevicePage({
    required this.myDevicesStore,
    Key? key,
  }) : super(key: key);
  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePageState();
}

class _ConnectDevicePageState extends State<ConnectDevicePage> {
  final ScanNewDevicestore _scanNewDevicestore = Modular.get();
  final EmptyDevicesListStore _emptyListStore = Modular.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getdevice();
    });
  }

  Future<void> _getdevice() async {
    log(widget.myDevicesStore.state.deviceModelType!.toString());
    await _scanNewDevicestore.getScannedDevicesBluetooth(
      widget.myDevicesStore.state.deviceModelType!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: MyDevicesLabels.connectDeviceTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<ScanNewDevicestore, Exception, bool>(
        store: _scanNewDevicestore,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const ScanDevicesBluetoothWidget(
              text: MyDevicesLabels.connectDevicesearchingDevices,
            );
          } else {
            return StreamBuilder<void>(
              stream: Stream.periodic(
                const Duration(seconds: 5),
              ).asyncMap(
                (_) async {
                  await _scanNewDevicestore.getScannedDevicesBluetoothStream(
                    widget.myDevicesStore.state.deviceModelType!,
                  );
                },
              ),
              builder: (context, snapshot) {
                return TripleBuilder<EmptyDevicesListStore, Exception, bool>(
                  store: _emptyListStore,
                  builder: (_, tripleEmpty) {
                    if (tripleEmpty.state) {
                      return const Center(
                        child: NoDevicesFoundWidget(
                          text: MyDevicesLabels.connectDeviceEmpty,
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var device
                                in _scanNewDevicestore.scannedDevicesList)
                              ItemListDeviceWidget(
                                buttonText:
                                    MyDevicesLabels.connectDevicDisconnect,
                                device: device.device,
                                myDevicesStore: widget.myDevicesStore,
                                onTap: () async {
                                  if (widget.myDevicesStore.state
                                      .deviceModelType!.needPin) {
                                    Modular.to.pushReplacementNamed(
                                      'pair_device',
                                      arguments: {
                                        'myDevicesStore': widget.myDevicesStore,
                                        'connectedDevice': device.device,
                                      },
                                    );
                                  } else {
                                    _scanNewDevicestore
                                        .connectDevice(device.device)
                                        .then(
                                      (value) async {
                                        Modular.to.pushReplacementNamed(
                                          'success_page',
                                          arguments: {
                                            'myDevicesStore':
                                                widget.myDevicesStore,
                                            'connectedDevice': device.device,
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
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
      ),
      bottomNavigationBar: TripleBuilder<ScanNewDevicestore, Exception, bool>(
        store: _scanNewDevicestore,
        builder: (_, triplo) {
          return BottomButtonWidget(
            isDisabled: triplo.isLoading,
            text: MyDevicesLabels.connectDeviceSearchDevices,
            onPressed: () async {
              await BluetoothServices.stopScanDevices();
              Helpers.checkDevicebluetoothIsOn().then(
                (isOn) {
                  if (!isOn) {
                    Helpers.showDialog(
                      context,
                      Container(
                        color: Theme.of(context).colorScheme.background,
                        padding: const EdgeInsets.only(top: 15),
                        child: const EnableBluetoothWidget(),
                      ),
                    );
                  } else {
                    _scanNewDevicestore.getScannedDevicesBluetooth(
                      widget.myDevicesStore.state.deviceModelType!,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
