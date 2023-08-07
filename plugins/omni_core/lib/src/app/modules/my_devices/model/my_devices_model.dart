import 'package:omni_measurement/omni_measurement.dart';

class MyDeviceModel {
  bool? isPaired;
  MeasurementType? measurementType;
  DeviceModelType? deviceModelType;
  MyDeviceModel({
    this.isPaired,
    this. measurementType,
    this.deviceModelType,
  });

  MyDeviceModel.fromJson(Map<String, dynamic> json) {

    isPaired = json['is_paired'];
    measurementType = json['measurement_type'];
    deviceModelType = json['device_model_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_paired'] = isPaired;

    data['measurement_type'] = measurementType;
    data['device_model_type'] = deviceModelType;
    return data;
  }
}
