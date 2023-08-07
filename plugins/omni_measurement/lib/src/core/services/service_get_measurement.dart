import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:omni_general/omni_general.dart';

// ignore: avoid_classes_with_only_static_members
class ServiceGetMeasurement {
  //TODO: GET GLUCOMETER ACG925
  static Future<String> getGlucoseMeterACG925(
    BluetoothDevice deviceBle,
  ) async {
    const String serviceUUID = '00001808-0000-1000-8000-00805f9b34fb';
    const String characteristicUUID = '00002a18-0000-1000-8000-00805f9b34fb';
    const String racpUUID = '00002a18-0000-1000-8000-00805f9b34fb';
    List<int> result = [];

    final services = await BluetoothServices.discoverServices(deviceBle);

    final BluetoothService service = services
        .firstWhere((service) => service.uuid.toString().contains(serviceUUID));

    final characteristic = await BluetoothServices.getCharacteristicInService(
      service,
      characteristicUUID,
    );

    final racp = await BluetoothServices.getCharacteristicInService(
      service,
      racpUUID,
    );

    await BluetoothServices.setNotifyValue(characteristic, true);

    characteristic.value.listen((value) {
      value.isNotEmpty ? result = value : null;
    });
    log('Result: ${result[12]}');

    return result[12].toString();
  }

  //TODO: GET BLOOD PRESSURE HEM6232T
  static Future<String> getBloodPressureHEM6232T(
    BluetoothDevice deviceBle,
  ) async {
    List<int> result = [];
    const String serviceUUID = '00001810-0000-1000-8000-00805f9b34fb';
    const String characteristicUUID = '00002a35-0000-1000-8000-00805f9b34fb';

    if (Platform.isAndroid) {
      final state = await deviceBle.connectionState.first;
      if (state == BluetoothConnectionState.disconnected) {
        await deviceBle.connect();
        await deviceBle.pair();
      } else {
        await deviceBle.pair();
      }
    }

    final services = await BluetoothServices.discoverServices(deviceBle);

    final service = services
        .firstWhere((service) => service.uuid.toString().contains(serviceUUID));

    final characteristic = await BluetoothServices.getCharacteristicInService(
      service,
      characteristicUUID,
    );

    await BluetoothServices.setNotifyValue(characteristic, true);

    characteristic.value.listen((value) {
      log('Value: $value');
      value.isNotEmpty ? result = value : null;
    });

    await Future.delayed(const Duration(seconds: 3));

    return '${result[01]}/${result[03]}/${result[14]}';
  }

  //TODO: GET BLOOD PRESSURE TD3128
  static Future<String> getBloodPressureTD3128(
    BluetoothDevice deviceBle,
  ) async {
    List<int> result = [];
    const String serviceUUID = '00001810-0000-1000-8000-00805f9b34fb';
    const String characteristicUUID = '00002a35-0000-1000-8000-00805f9b34fb';

    final services = await BluetoothServices.discoverServices(deviceBle);

    final service = services
        .firstWhere((service) => service.uuid.toString().contains(serviceUUID));

    final characteristic = await BluetoothServices.getCharacteristicInService(
      service,
      characteristicUUID,
    );

    await BluetoothServices.setNotifyValue(characteristic, true);

    if (Platform.isAndroid) {
      characteristic.value.listen((value) {
        value.isNotEmpty ? result = value : null;
      });
    } else {
      characteristic.read().then((value) {
        value.isNotEmpty ? result = value : null;
      });
    }

    await Future.delayed(const Duration(seconds: 3));

    if (result.isNotEmpty) {
      log('Chegou resultado: $result');
      return '${result[01]}/${result[03]}/${result[14]}';
    } else {
      log('Chegou em null: $result');
      return '';
    }
  }

  //TODO: GET OXIMETER TD8255
  static Future<String> getOximeterTD8255(BluetoothDevice deviceBle) async {
    List<int> result = [];
    const String serviceUUID = '00001809-0000-1000-8000-00805f9b34fb';
    const String characteristicUUID = '00002a1c-0000-1000-8000-00805f9b34fb';

    final services = await BluetoothServices.discoverServices(deviceBle);

    final service = services
        .firstWhere((service) => service.uuid.toString().contains(serviceUUID));

    final characteristic = await BluetoothServices.getCharacteristicInService(
      service,
      characteristicUUID,
    );

    await BluetoothServices.setNotifyValue(characteristic, true);

    characteristic.value.listen((value) {
      value.isNotEmpty ? result = value : null;
    });

    await Future.delayed(const Duration(seconds: 5));

    final int numberOne = result[2];
    final int numberTwo = result[1];

    return (int.parse(
              '${numberOne.toRadixString(16)}${numberTwo.toRadixString(16)}',
              radix: 16,
            ) ~/
            10)
        .toString();
  }

  //TODO: GET OXIMETER NONIN3230
  static Future<String> getOximeterNonin3230(
    BluetoothDevice deviceBle,
  ) async {
    List<int> result = [];
    const String serviceUUID = '46a970e0-0d5f-11e2-8b5e-0002a5d5c51b';
    const String characteristicUUID = '0aad7ea0-0d60-11e2-8e3c-0002a5d5c51b';

    final services = await BluetoothServices.discoverServices(deviceBle);

    final service = services
        .firstWhere((service) => service.uuid.toString().contains(serviceUUID));

    final characteristic = await BluetoothServices.getCharacteristicInService(
      service,
      characteristicUUID,
    );

    await BluetoothServices.setNotifyValue(characteristic, true);

    characteristic.value.listen((value) {
      value.isNotEmpty ? result = value : null;
    });

    await Future.delayed(const Duration(seconds: 3));

    await BluetoothServices.setNotifyValue(characteristic, false);

    return result[07].toString();
  }

  //TODO: GET OXIMETER MD300C208
  static Future<String> getOximeterMD300C208(
    BluetoothDevice deviceBle,
  ) async {
    const String serviceUUID = 'ba11f08c-5f14-0b0d-1080';
    final List<int> sendData = [0xaa, 0x55, 0x04, 0xb1, 0x00, 0x00, 0xb5];
    List<int> result = [];

    final services = await BluetoothServices.discoverServices(deviceBle);

    final service = services
        .firstWhere((service) => service.uuid.toString().contains(serviceUUID));

    final characteristicWrite =
        await BluetoothServices.getCharacteristicInService(service, '0000cd20');

    final characteristicRead =
        await BluetoothServices.getCharacteristicInService(service, '0000cd04');

    await BluetoothServices.setNotifyValueCharacteristicInService(
      service,
      '0000cd0',
      true,
    );

    await BluetoothServices.writeCharacteristic(characteristicWrite, sendData);

    characteristicRead.value.listen((value) {
      value.isNotEmpty ? result = value : null;
    });

    await Future.delayed(const Duration(seconds: 5));

    return result[3].toString();
  }
}
