import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:omni_measurement/src/core/enums/device_model_enum.dart';

class GetMeasurement {
  Future<String> getOximeterMeasureNONIN3230(
    BluetoothDevice device,
    DeviceModelType deviceModelType,
  ) async {
    int finalOximeterValue = 0;
    BluetoothCharacteristic oximeterMeasurement;
    BluetoothService oximeterService;

    device.services.forEach(
      (services) async {
        oximeterService = services.firstWhere(
          (service) =>
              service.uuid.toString().contains(deviceModelType.serviceUUID),
        );
        oximeterMeasurement = oximeterService.characteristics.firstWhere(
          (element) => element.uuid
              .toString()
              .contains(deviceModelType.characteristicUUID),
        );
        try {
          log('Iniciando configuracão da caracteristica 7ea0');
          oximeterMeasurement.setNotifyValue(true);
          oximeterMeasurement.value.listen(
            (value) {
              if (value[07].toString() != '127') {
                finalOximeterValue = value[07];
                log('Evento ouvindo caracteristica');
              }
            },
          );
          log('caracteristica configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a caracteristica');
        }
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    return finalOximeterValue.toString();
  }

  Future<String> getOximeterMeasureTD8255(
    BluetoothDevice device,
    DeviceModelType deviceModelType,
  ) async {
    BluetoothCharacteristic oximeterMeasurement;
    BluetoothService oximeterService;

    int _firstHexOximeterValueInt = 0;
    int _secondHexOximeterValueInt = 0;
    String _finalOximeterValueString = '';
    int _finalOximeterValueInt = 0;

    device.services.forEach(
      (services) async {
        oximeterService = services.firstWhere(
          (service) =>
              service.uuid.toString().contains(deviceModelType.serviceUUID),
        );
        oximeterMeasurement = oximeterService.characteristics.firstWhere(
          (element) => element.uuid
              .toString()
              .contains(deviceModelType.characteristicUUID),
        );
        try {
          log('Iniciando configuracão da caracteristica 2a1c');
          oximeterMeasurement.setNotifyValue(true);
          oximeterMeasurement.value.listen(
            (value) {
              // firstHexOximeterValue = value[2].toRadixString(16);
              // secondHexOximeterValue = value[1].toRadixString(16);

              // finalHexOximeterValue =
              //     '$firstHexOximeterValue$secondHexOximeterValue';
              // finalOximeterValue =
              //     int.parse(finalHexOximeterValue, radix: 16) ~/ 10;

              _firstHexOximeterValueInt = value[2];
              _secondHexOximeterValueInt = value[1];
              _finalOximeterValueString =
                  '${_firstHexOximeterValueInt.toRadixString(16)}${_secondHexOximeterValueInt.toRadixString(16)}';
              _finalOximeterValueInt =
                  int.parse(_finalOximeterValueString, radix: 16) ~/ 10;

              log('Ouvindo caracteristica TD8255: $_finalOximeterValueInt');
            },
          );
          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    return _finalOximeterValueInt.toString();
  }

  Future<String> getGlucoseMeasureACG925(BluetoothDevice device) async {
    BluetoothCharacteristic glucoseMeasurement;
    int glucoseMeasure = 0;
    BluetoothCharacteristic glucoseContext;
    BluetoothCharacteristic racp;
    BluetoothService glucoseService;

    device.services.forEach(
      (services) async {
        glucoseService = services
            .firstWhere((service) => service.uuid.toString().contains('1808'));
        glucoseMeasurement = glucoseService.characteristics
            .firstWhere((element) => element.uuid.toString().contains('2a18'));
        racp = glucoseService.characteristics
            .firstWhere((element) => element.uuid.toString().contains('2a52'));

        try {
          log('Iniciando configuracão da caracteristica 2a18');
          await glucoseMeasurement.setNotifyValue(true);
          glucoseMeasurement.value.listen(
            (value) {
              glucoseMeasure = value[12];
              log('Evento ouvindo caracteristica');
            },
          );
          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
        try {
          log('Iniciando configuracão da caracteristica 2a52');
          await racp.setNotifyValue(true);
          await racp.write([1, 6]);

          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
        glucoseContext = glucoseService.characteristics
            .firstWhere((element) => element.uuid.toString().contains('2a34'));
        try {
          log('Iniciando configuracão da caracteristica 2a34');
          await glucoseContext.setNotifyValue(true);
          log('Notificação configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a notificação');
        }
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    return glucoseMeasure.toString();
  }

  Future<String> getPressureMeasureTD3128(
    BluetoothDevice device,
    DeviceModelType deviceModelType,
  ) async {
    int pressureSystolicMeasure = 0;
    int pressureDiastolicMeasure = 0;
    int pressureBPM = 0;
    BluetoothCharacteristic pressureMeasurement;
    BluetoothService pressureService;

    device.services.forEach(
      (services) async {
        pressureService = services.firstWhere(
          (service) => service.uuid.toString().contains(
                deviceModelType.serviceUUID,
              ),
        );
        pressureMeasurement = pressureService.characteristics.firstWhere(
          (element) => element.uuid.toString().contains(
                deviceModelType.characteristicUUID,
              ),
        );
        try {
          log('Iniciando configuracão da caracteristica 2a35');
          pressureMeasurement.setNotifyValue(true);
          pressureMeasurement.value.listen(
            (value) {
              pressureSystolicMeasure = value[01];
              pressureDiastolicMeasure = value[03];
              pressureBPM = value[14];
              log('Evento ouvindo caracteristica');
            },
          );
          log('caracteristica configurada com sucesso!');
        } catch (e) {
          log('Erro ao configurar a caracteristica');
        }
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    return '${pressureSystolicMeasure.toString()}/${pressureDiastolicMeasure.toString()}/${pressureBPM.toString()}';
  }
}
