import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/widgets/connect_device_buttom_widget.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/widgets/item_list_device_widget.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/empty_devices_list_store.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/scan_new_devices_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

class DevicesManagementPage extends StatefulWidget {
  final MyDevicesStore myDevicesStore;
  const DevicesManagementPage({
    required this.myDevicesStore,
    Key? key,
  }) : super(key: key);

  @override
  State<DevicesManagementPage> createState() => _DevicesManagementPageState();
}

class _DevicesManagementPageState extends State<DevicesManagementPage> {
  final EmptyDevicesListStore _emptyListStore = Modular.get();
  final ScanNewDevicestore _scanNewDevicestore = Modular.get();

  @override
  void initState() {
    getdevice();
    super.initState();
  }

  Future<void> getdevice() async {
    await _scanNewDevicestore.getDevicesConnectedBluetooth(
      widget.myDevicesStore.state.deviceModelType!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.myDevicesStore.state.deviceModelType!.label,
      ).build(context) as AppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TripleBuilder<ScanNewDevicestore, Exception, bool>(
              store: _scanNewDevicestore,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const Center(
                    child: ScanDevicesBluetoothWidget(
                      text: MyDevicesLabels.devicesManagementSearchingDevices,
                    ),
                  );
                } else {
                  return StreamBuilder<void>(
                    stream: Stream.periodic(
                      const Duration(seconds: 3),
                    ).asyncMap(
                      (_) async {
                        await _scanNewDevicestore
                            .getDevicesConnectedBluetoothStream(
                          widget.myDevicesStore.state.deviceModelType!,
                        );
                      },
                    ),
                    builder: (context, snapshot) {
                      return TripleBuilder<EmptyDevicesListStore, Exception,
                          bool>(
                        store: _emptyListStore,
                        builder: (_, triplo) {
                          return Column(
                            mainAxisAlignment: triplo.state
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: [
                              if (triplo.state)
                                const NoDevicesFoundWidget(
                                  text: MyDevicesLabels.devicesManagementEmpty,
                                )
                              else
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (final device in _scanNewDevicestore
                                          .connectedDevicesList)
                                        ItemListDeviceWidget(
                                          buttonText: MyDevicesLabels
                                              .devicesManagementDisconnect,
                                          device: device,
                                          myDevicesStore: widget.myDevicesStore,
                                          onTap: () async {
                                            _scanNewDevicestore
                                                .disconnectDevice(device)
                                                .then((value) {
                                              _emptyListStore.setEmpty(true);
                                            }).catchError((onError) {
                                              Helpers.showDialog(
                                                context,
                                                RequestErrorWidget(
                                                  error: onError,
                                                  onPressed: () =>
                                                      Modular.to.pop(),
                                                  buttonText:
                                                      MyDevicesLabels.close,
                                                ),
                                                showClose: true,
                                              );
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConnectDeviceButtomWidget(
              myDevicesStore: widget.myDevicesStore,
            ),
          ),
        ],
      ),
    );
  }
}
