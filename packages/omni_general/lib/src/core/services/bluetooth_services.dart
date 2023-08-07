import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothServices {
  static Future<void> getPermission() async {
    await Permission.location.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothConnect.request();
  }

  static Future<bool> checkDevicebluetoothIsOn() async {
    return FlutterBluePlus.isOn;
  }

  static Future<List<BluetoothDevice>> getDevicesConnected() async {
    return FlutterBluePlus.connectedSystemDevices;
  }

  static Future<void> stopScanDevices() async {
    await FlutterBluePlus.stopScan();
  }

  static Future<void> startScan() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 3),
    ).catchError((error) {
      log('Erro scan: $error');
    });
  }

  static Future<void> connectDevice(BluetoothDevice device) async {
    await device.connect();
  }

  static Future<void> disconnectDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  static Future<List<BluetoothService>> discoverServices(
    BluetoothDevice device,
  ) async {
    return device.discoverServices();
  }

  static Future<void> readCharacteristic(
    BluetoothCharacteristic characteristic,
  ) async {
    await characteristic.read();
  }

  static Future<bool> writeCharacteristic(
    BluetoothCharacteristic characteristic,
    List<int> value,
  ) async {
    return characteristic.write(value).then((value) => true);
  }

  static Future<void> setNotifyValue(
    BluetoothCharacteristic characteristic,
    bool enable,
  ) async {
    await characteristic.setNotifyValue(enable);
  }

  static Future<List<int>> readCharacteristicValue(
    BluetoothCharacteristic characteristic,
  ) async {
    return characteristic.read();
  }

  static Future<void> readDescriptor(BluetoothDescriptor descriptor) async {
    await descriptor.read();
  }

  static Future<void> writeDescriptor(
    BluetoothDescriptor descriptor,
    List<int> value,
  ) async {
    await descriptor.write(value);
  }

  static Future<void> readRssi(BluetoothDevice device) async {
    await device.readRssi();
  }

  static Future<void> requestMtu(BluetoothDevice device, int mtu) async {
    await device.requestMtu(mtu);
  }

  static Future<BluetoothConnectionState> getBluetoothState(
    BluetoothDevice device,
  ) async {
    return device.connectionState.last;
  }

  static Future<BluetoothConnectionState> getDeviceState(
    BluetoothDevice device,
  ) async {
    return device.state.last;
  }

  static Future<BluetoothCharacteristic> getCharacteristicInService(
    BluetoothService service,
    String uuid,
  ) async {
    BluetoothCharacteristic? characteristic;
    for (final item in service.characteristics) {
      if (item.uuid.toString().contains(uuid)) {
        characteristic = item;
      }
    }
    return characteristic!;
  }

  static Future<void> setNotifyValueCharacteristicInService(
    BluetoothService service,
    String uuid,
    bool enable,
  ) async {
    for (final characteristic in service.characteristics) {
      characteristic.uuid.toString().contains(uuid)
          ? await BluetoothServices.setNotifyValue(characteristic, enable)
          : null;
    }
  }
}
