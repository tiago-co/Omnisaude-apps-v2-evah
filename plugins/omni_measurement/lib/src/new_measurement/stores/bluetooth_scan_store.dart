import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/enums/device_model_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/new_measurement/stores/empty_list_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';

class BluetoothScanStore extends NotifierStore<Exception, bool> {
  BluetoothScanStore() : super(false);

  final EmptyListStore emptyListStore = Modular.get();
  final NewMeasurementStore store = Modular.get();

  List<ScanResult> scannedDevicesList = List.empty(growable: true);
  List<BluetoothDevice> connectedDevicesList = List.empty(growable: true);

  List<String> getNamesList(MeasurementType type) {
    final List<String> nameDevices = List.empty(growable: true);

    for (final DeviceModelType deviceType in type.typeDevice) {
      for (final String name in deviceType.nameScanList) {
        if (!nameDevices.contains(name.toLowerCase())) {
          nameDevices.add(name.toLowerCase());
        }
      }
    }
    return nameDevices;
  }

  Future<void> startScan(MeasurementType type) async {
    store.isScanning = false;
    store.updateForm(store.state);
    await BluetoothServices.startScan();
    store.isScanning = true;
    store.updateForm(store.state);
  }

  Future<void> startScanStream(MeasurementType type) async {
    await BluetoothServices.startScan();
  }

  Future<void> getDevicesScanned(MeasurementType type) async {
    final List<ScanResult> devices = List.empty(growable: true);
    final List<String> nameDevices = getNamesList(type);

    FlutterBluePlus.scanResults.listen(
      (listScan) {
        for (final device in listScan) {
          for (final name in nameDevices) {
            if (device.device.name.toLowerCase().contains(name) &
                !devices.contains(device)) {
              devices.add(device);
            }
          }
        }
      },
    );
    scannedDevicesList = devices;
  }

  Future<void> getDevicesConnected(MeasurementType type) async {
    List<BluetoothDevice> devices = List.empty(growable: true);
    final List<String> nameDevices = getNamesList(type);

    devices = await FlutterBluePlus.connectedSystemDevices;

    for (final device in devices) {
      for (final name in nameDevices) {
        if (device.name.toLowerCase().contains(name) &
            !connectedDevicesList.contains(device)) {
          connectedDevicesList.add(device);
        }
      }
    }
  }

  void validateList() {
    if (scannedDevicesList.isEmpty && connectedDevicesList.isEmpty) {
      emptyListStore.setEmpty(true);
    } else {
      emptyListStore.setEmpty(false);
    }
  }

  Future<void> startScanningDevices(MeasurementType type) async {
    setLoading(true);
    scannedDevicesList.clear();
    connectedDevicesList.clear();
    await startScan(type);
    await getDevicesScanned(type);
    await getDevicesConnected(type);
    validateList();
    setLoading(false);
  }

  Future<void> startScanningDevicesStream(MeasurementType type) async {
    scannedDevicesList.clear();
    connectedDevicesList.clear();
    await startScanStream(type);
    await getDevicesScanned(type);
    await getDevicesConnected(type);
    validateList();
  }
}
