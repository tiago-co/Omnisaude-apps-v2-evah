import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/my_devices/model/my_devices_model.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

// ignore: must_be_immutable
class MyDevicesStore extends NotifierStore<Exception, MyDeviceModel> {
  MyDevicesStore()
      : super(
          MyDeviceModel(
            isPaired: false,
          ),
        );
  final UserStore userStore = Modular.get<UserStore>();

  bool isPairing = false;

  Future<void> connect(BluetoothDevice device) async {
    setLoading(true);
    await device.connect();
    setLoading(false);
  }

  Future<void> disconenct(BluetoothDevice device) async {
    setLoading(true);
    await device.disconnect().whenComplete(() {
      setLoading(false);
    });
  }

  // void addDeviceToList(BluetoothDevice device) {
  //   switch (state.deviceModelType) {
  //     case DeviceModelType.acg925:
  //       final existingItem =
  //           userStore.state.pairedDevices!.accuCheckGuideList!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       if (existingItem == '') {
  //         userStore.state.pairedDevices!.accuCheckGuideList!.add(
  //           device.id.id,
  //         );
  //         userStore.setUserPreferences(
  //           userStore.state,
  //           userStore.state.jwt!.id!,
  //         );
  //       }
  //       break;
  //     case DeviceModelType.td3128:
  //       final existingItem =
  //           userStore.state.pairedDevices!.td3128List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       if (existingItem == '') {
  //         userStore.state.pairedDevices!.td3128List!.add(
  //           device.id.id,
  //         );
  //         userStore.setUserPreferences(
  //           userStore.state,
  //           userStore.state.jwt!.id!,
  //         );
  //       }
  //       break;
  //     case DeviceModelType.td8255:
  //       final existingItem =
  //           userStore.state.pairedDevices!.td8255List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       if (existingItem == '') {
  //         userStore.state.pairedDevices!.td8255List!.add(
  //           device.id.id,
  //         );
  //         userStore.setUserPreferences(
  //           userStore.state,
  //           userStore.state.jwt!.id!,
  //         );
  //       }
  //       break;
  //     case DeviceModelType.nonin3230:
  //       final existingItem =
  //           userStore.state.pairedDevices!.nonin3230List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       if (existingItem == '') {
  //         userStore.state.pairedDevices!.nonin3230List!.add(
  //           device.id.id,
  //         );
  //         userStore.setUserPreferences(
  //           userStore.state,
  //           userStore.state.jwt!.id!,
  //         );
  //       }
  //       break;
  //     case DeviceModelType.md300c208:
  //       final existingItem =
  //           userStore.state.pairedDevices!.md300c208List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       if (existingItem == '') {
  //         userStore.state.pairedDevices!.md300c208List!.add(
  //           device.id.id,
  //         );
  //         userStore.setUserPreferences(
  //           userStore.state,
  //           userStore.state.jwt!.id!,
  //         );
  //       }
  //       break;
  //     case DeviceModelType.hem6232t:
  //       final existingItem =
  //           userStore.state.pairedDevices!.hem6232tList!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       if (existingItem == '') {
  //         userStore.state.pairedDevices!.hem6232tList!.add(
  //           device.id.id,
  //         );
  //         userStore.setUserPreferences(
  //           userStore.state,
  //           userStore.state.jwt!.id!,
  //         );
  //       }
  //       break;
  //     case null:
  //       break;
  //   }
  // }

  // void removeDeviceFromList(BluetoothDevice device) {
  //   switch (state.deviceModelType) {
  //     case null:
  //       break;
  //     case DeviceModelType.acg925:
  //       userStore.state.pairedDevices!.accuCheckGuideList!.removeWhere(
  //         (element) => element == device.id.id,
  //       );
  //       userStore.setUserPreferences(
  //         userStore.state,
  //         userStore.state.jwt!.id!,
  //       );
  //       break;
  //     case DeviceModelType.td3128:
  //       userStore.state.pairedDevices!.td3128List!.removeWhere(
  //         (element) => element == device.id.id,
  //       );
  //       userStore.setUserPreferences(
  //         userStore.state,
  //         userStore.state.jwt!.id!,
  //       );
  //       break;
  //     case DeviceModelType.td8255:
  //       userStore.state.pairedDevices!.td8255List!.removeWhere(
  //         (element) => element == device.id.id,
  //       );
  //       userStore.setUserPreferences(
  //         userStore.state,
  //         userStore.state.jwt!.id!,
  //       );
  //       break;
  //     case DeviceModelType.nonin3230:
  //       userStore.state.pairedDevices!.nonin3230List!.removeWhere(
  //         (element) => element == device.id.id,
  //       );
  //       userStore.setUserPreferences(
  //         userStore.state,
  //         userStore.state.jwt!.id!,
  //       );
  //       break;
  //     case DeviceModelType.md300c208:
  //       userStore.state.pairedDevices!.md300c208List!.removeWhere(
  //         (element) => element == device.id.id,
  //       );
  //       userStore.setUserPreferences(
  //         userStore.state,
  //         userStore.state.jwt!.id!,
  //       );
  //       break;
  //     case DeviceModelType.hem6232t:
  //       userStore.state.pairedDevices!.hem6232tList!.removeWhere(
  //         (element) => element == device.id.id,
  //       );
  //       userStore.setUserPreferences(
  //         userStore.state,
  //         userStore.state.jwt!.id!,
  //       );
  //       break;
  //   }
  // }

  // bool verifyType(BluetoothDevice device) {
  //   String existingItem = '';
  //   switch (state.deviceModelType) {
  //     case null:
  //       break;
  //     case DeviceModelType.acg925:
  //       existingItem =
  //           userStore.state.pairedDevices!.accuCheckGuideList!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       break;
  //     case DeviceModelType.td3128:
  //       existingItem = userStore.state.pairedDevices!.td3128List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       break;
  //     case DeviceModelType.td8255:
  //       existingItem = userStore.state.pairedDevices!.td8255List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       break;
  //     case DeviceModelType.nonin3230:
  //       existingItem = userStore.state.pairedDevices!.nonin3230List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       break;
  //     case DeviceModelType.md300c208:
  //       existingItem = userStore.state.pairedDevices!.md300c208List!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       break;
  //     case DeviceModelType.hem6232t:
  //       existingItem = userStore.state.pairedDevices!.hem6232tList!.firstWhere(
  //         (element) => element == device.id.id,
  //         orElse: () => '',
  //       );
  //       break;
  //   }

  //   return existingItem == '';
  // }

  Future<void> pairDevice(BluetoothDevice connectedDevice) async {
    setLoading(true);
    isPairing = true;

    BluetoothCharacteristic deviceMeasurement;
    BluetoothService deviceService;

    final Stream<List<ScanResult>> devicesList = FlutterBluePlus.scanResults;

    devicesList.forEach((results) async {
      results.forEach((result) async {
        if (result.device.id == connectedDevice.id) {
          await BluetoothServices.connectDevice(result.device);
          await BluetoothServices.discoverServices(result.device);
          await result.device.services.forEach((services) async {
            deviceService = services.firstWhere(
              (service) => service.uuid
                  .toString()
                  .contains(state.deviceModelType!.serviceUUID),
            );
            deviceMeasurement = deviceService.characteristics.firstWhere(
              (element) => element.uuid
                  .toString()
                  .contains(state.deviceModelType!.characteristicUUID),
            );
            try {
              log('Iniciando configuracão da caracteristica 2a18');

              await BluetoothServices.setNotifyValue(deviceMeasurement, true)
                  .whenComplete(() {
                update(MyDeviceModel.fromJson(state.toJson()));
              });
              log('Notificação configurada com sucesso!');
              state.isPaired = true;
              update(MyDeviceModel.fromJson(state.toJson()));
            } catch (e) {
              // BluetoothServices.disconnectDevice(result.device);
              log('Erro ao configurar a notificação');
            }
          });
        }
      });
    });
    setLoading(false);
    isPairing = false;
  }
}
