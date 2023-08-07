import 'package:omni_measurement/src/core/enums/device_model_enum.dart';
import 'package:omni_measurement_labels/labels.dart';

enum MeasurementType {
  glucose,
  pressure,
  oxygen,
  temperature,
}

extension MeasurementTypeExtension on MeasurementType {
  String get label {
    switch (this) {
      case MeasurementType.glucose:
        return MeasurementLabels.measurementTypeGlucose;
      case MeasurementType.pressure:
        return MeasurementLabels.measurementTypePressure;
      case MeasurementType.oxygen:
        return MeasurementLabels.measurementTypeOxygen;
      case MeasurementType.temperature:
        return MeasurementLabels.measurementTypeTemperature;
    }
  }

  String? get toJson {
    switch (this) {
      case MeasurementType.glucose:
        return 'glicose';
      case MeasurementType.pressure:
        return 'pressao';
      case MeasurementType.oxygen:
        return 'oxigenio';
      case MeasurementType.temperature:
        return 'temperatura';
    }
  }

  String get pageTitle {
    switch (this) {
      case MeasurementType.glucose:
        return 'Glicosímetro';
      case MeasurementType.pressure:
        return 'Monitor de Pressão Arterial';
      case MeasurementType.oxygen:
        return 'Oxímetro';
      case MeasurementType.temperature:
        return 'Termômetro';
    }
  }

  String get asset {
    switch (this) {
      case MeasurementType.glucose:
        return 'assets/icons/type_measurement/glucose_icon.svg';
      case MeasurementType.pressure:
        return 'assets/icons/type_measurement/blood_pressure_icon.svg';
      case MeasurementType.oxygen:
        return 'assets/icons/type_measurement/oximeter_icon.svg';
      case MeasurementType.temperature:
        return 'assets/icons/type_measurement/temperature_icon.svg';
    }
  }

  String get infoTypeMeasuarement {
    switch (this) {
      case MeasurementType.glucose:
        return 'Informar medição de Glicemia';
      case MeasurementType.pressure:
        return 'Informar medição de Pressão Arterial';
      case MeasurementType.oxygen:
        return 'Informar medição de Oximetria';
      case MeasurementType.temperature:
        return 'Informar medição de Temperatura';
    }
  }

  List<DeviceModelType> get typeDevice {
    switch (this) {
      case MeasurementType.glucose:
        return [
          DeviceModelType.acg925,
        ];
      case MeasurementType.pressure:
        return [
          DeviceModelType.td3128,
          DeviceModelType.hem6232t,
        ];
      case MeasurementType.oxygen:
        return [
          DeviceModelType.nonin3230,
          DeviceModelType.td8255,
          DeviceModelType.md300c208,
        ];
      case MeasurementType.temperature:
        return [
          // DeviceModelType.td1261,
        ];
    }
  }

  String get deviceMeasurementType {
    switch (this) {
      case MeasurementType.glucose:
        return 'mg/dL';
      case MeasurementType.pressure:
        return 'mmHg';
      case MeasurementType.oxygen:
        return 'SpO2';
      case MeasurementType.temperature:
        return '°C';
    }
  }

  String get typeOfMonitoring {
    switch (this) {
      case MeasurementType.glucose:
        return 'Glicemia';
      case MeasurementType.pressure:
        return 'Pressão Arterial';
      case MeasurementType.oxygen:
        return 'Oximetria';
      case MeasurementType.temperature:
        return 'Temperatura';
    }
  }
}

MeasurementType? measurementTypeFromJson(String? type) {
  switch (type) {
    case 'glicose':
      return MeasurementType.glucose;
    case 'pressao':
      return MeasurementType.pressure;
    case 'oxigenio':
      return MeasurementType.oxygen;
    case 'temperatura':
      return MeasurementType.temperature;
  }
  return null;
}
