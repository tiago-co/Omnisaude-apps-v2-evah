import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/empty_devices_list_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

class ScanNewDevicestore extends NotifierStore<Exception, bool> {
  ScanNewDevicestore() : super(false);

  final EmptyDevicesListStore emptyListStore = Modular.get();

  List<ScanResult> scannedDevicesList = List.empty(growable: true);
  List<BluetoothDevice> connectedDevicesList = List.empty(growable: true);

  Future<void> startScan() async {
    await BluetoothServices.startScan();
  }

  Future<void> getDevicesScanned(DeviceModelType type) async {
    final List<String> nameDevices = List.empty(growable: true);

    for (final String device in type.nameScanList) {
      if (!nameDevices.contains(device.toLowerCase())) {
        nameDevices.add(device.toLowerCase());
      }
    }

    FlutterBluePlus.scanResults.listen(
      (listScan) {
        for (final device in listScan) {
          for (final name in nameDevices) {
            if (device.device.name.toLowerCase().contains(name) &&
                !scannedDevicesList.contains(device)) {
              scannedDevicesList.add(device);
            }
          }
        }
      },
    );
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    setLoading(true);
    await BluetoothServices.disconnectDevice(device);
    setLoading(false);
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    setLoading(true);
    await BluetoothServices.connectDevice(device);
    setLoading(false);
  }

  void validateScannedList() {
    if (scannedDevicesList.isEmpty) {
      emptyListStore.setEmpty(true);
    } else {
      emptyListStore.setEmpty(false);
    }
  }

  void validateConnectedList() {
    if (connectedDevicesList.isEmpty) {
      emptyListStore.setEmpty(true);
    } else {
      emptyListStore.setEmpty(false);
    }
  }

  Future<void> getScannedDevicesBluetooth(DeviceModelType type) async {
    setLoading(true);
    await startScan();
    scannedDevicesList.clear();
    await getDevicesScanned(type);
    validateScannedList();
    setLoading(false);
  }

  Future<void> getScannedDevicesBluetoothStream(DeviceModelType type) async {
    scannedDevicesList.clear();
    await startScan();
    await getDevicesScanned(type);
    validateScannedList();
  }

  Future<void> getDevicesConnected(DeviceModelType type) async {
    List<BluetoothDevice> connect = List.empty(growable: true);
    final List<String> nameDevices = List.empty(growable: true);
    for (final String device in type.nameScanList) {
      if (!nameDevices.contains(device.toLowerCase())) {
        nameDevices.add(device.toLowerCase());
      }
    }

    connect = await BluetoothServices.getDevicesConnected();
    for (final device in connect) {
      for (final name in nameDevices) {
        if (device.name.toLowerCase().contains(name) &&
            !connectedDevicesList.contains(device)) {
          connectedDevicesList.add(device);
        }
      }
    }
  }

  Future<void> getDevicesConnectedBluetooth(DeviceModelType type) async {
    setLoading(true);
    connectedDevicesList.clear();
    await getDevicesConnected(type);
    await Future.delayed(const Duration(seconds: 2));
    validateConnectedList();
    setLoading(false);
  }

  Future<void> getDevicesConnectedBluetoothStream(DeviceModelType type) async {
    connectedDevicesList.clear();
    await getDevicesConnected(type);
    await Future.delayed(const Duration(seconds: 2));
    validateConnectedList();
  }
}
