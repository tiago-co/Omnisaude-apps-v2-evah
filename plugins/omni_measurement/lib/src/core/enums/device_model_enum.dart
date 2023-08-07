import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:omni_measurement/src/core/services/service_get_measurement.dart';
import 'package:omni_measurement_labels/labels.dart';

enum DeviceModelType { acg925, td3128, td8255, nonin3230, md300c208, hem6232t }

extension DeviceModelTypeExtension on DeviceModelType {
  String get label {
    switch (this) {
      case DeviceModelType.acg925:
        return MeasurementLabels.deviceModelTypeAcg925;
      case DeviceModelType.td3128:
        return MeasurementLabels.deviceModelTypTd3128;
      case DeviceModelType.td8255:
        return MeasurementLabels.deviceModelTypeTd8255;
      case DeviceModelType.nonin3230:
        return MeasurementLabels.deviceModelTypeNonin3230;
      case DeviceModelType.md300c208:
        return MeasurementLabels.deviceModelTypeNd300c208;
      case DeviceModelType.hem6232t:
        return MeasurementLabels.deviceModelTypeHem6232t;
    }
  }

  List<String> get nameScanList {
    switch (this) {
      case DeviceModelType.acg925:
        return ['925'];
      case DeviceModelType.td3128:
        return ['3128'];
      case DeviceModelType.td8255:
        return ['8255'];
      case DeviceModelType.nonin3230:
        return ['nonin'];
      case DeviceModelType.md300c208:
        return ['md300c208'];
      case DeviceModelType.hem6232t:
        return ['6232t', 'bleSmart'];
    }
  }

  String get asset {
    switch (this) {
      case DeviceModelType.acg925:
        return 'assets/images/ACG-925.png';
      case DeviceModelType.td3128:
        return 'assets/images/TD-3128.png';
      case DeviceModelType.td8255:
        return 'assets/images/TD-8255.png';
      case DeviceModelType.nonin3230:
        return 'assets/images/NONIN-3230.png';
      case DeviceModelType.md300c208:
        return 'assets/images/MD300C208.png';
      case DeviceModelType.hem6232t:
        return 'assets/images/HEM-6232T.jpeg';
    }
  }

  String get serviceUUID {
    switch (this) {
      case DeviceModelType.acg925:
        return '1808';
      case DeviceModelType.td3128:
        return '00001810-0000-1000-8000-00805f9b34fb';
      case DeviceModelType.td8255:
        return '00001809-0000-1000-8000-00805f9b34fb';
      case DeviceModelType.nonin3230:
        return '46a970e0-0d5f-11e2-8b5e-0002a5d5c51b';
      case DeviceModelType.md300c208:
        return 'ba11f08c-5f14-0b0d-1080';
      case DeviceModelType.hem6232t:
        return '00001810-0000-1000-8000-00805f9b34fb';
    }
  }

  bool get needPin {
    switch (this) {
      case DeviceModelType.acg925:
        return false;
      case DeviceModelType.td3128:
        return false;
      case DeviceModelType.td8255:
        return false;
      case DeviceModelType.nonin3230:
        return false;
      case DeviceModelType.md300c208:
        return false;
      case DeviceModelType.hem6232t:
        return false;
    }
  }

  String get characteristicUUID {
    switch (this) {
      case DeviceModelType.acg925:
        return '2a18';
      case DeviceModelType.td3128:
        return '2a35';
      case DeviceModelType.td8255:
        return '2a1c';
      case DeviceModelType.nonin3230:
        return '7ea0';
      case DeviceModelType.md300c208:
        return 'f0c0';
      case DeviceModelType.hem6232t:
        return '2a35';
    }
  }

  Future<String> getMeasurement(BluetoothDevice device) async {
    switch (this) {
      case DeviceModelType.acg925:
        return ServiceGetMeasurement.getGlucoseMeterACG925(device);
      case DeviceModelType.td3128:
        return ServiceGetMeasurement.getBloodPressureTD3128(device);
      case DeviceModelType.td8255:
        return ServiceGetMeasurement.getOximeterTD8255(device);
      case DeviceModelType.nonin3230:
        return ServiceGetMeasurement.getOximeterNonin3230(device);
      case DeviceModelType.md300c208:
        return ServiceGetMeasurement.getOximeterMD300C208(device);
      case DeviceModelType.hem6232t:
        return ServiceGetMeasurement.getBloodPressureHEM6232T(device);
    }
  }
}
