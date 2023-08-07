import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';

class ItemListDeviceWidget extends StatelessWidget {
  final BluetoothDevice device;
  final MyDevicesStore myDevicesStore;
  final Function()? onTap;
  final String? buttonText;
  const ItemListDeviceWidget({
    Key? key,
    required this.device,
    required this.myDevicesStore,
    required this.onTap,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothConnectionState>(
      stream: device.connectionState,
      initialData: BluetoothConnectionState.disconnected,
      builder: (c, snapshot) {
        final deviceState = snapshot.data;
        return ListTile(
          title: Text(
            device.name,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            deviceState == BluetoothConnectionState.disconnected
                ? MyDevicesLabels.itemDeviceListDisconnected
                : MyDevicesLabels.itemDeviceListConnected,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: const Icon(
              Icons.bluetooth,
              color: Colors.white,
            ),
          ),
          trailing: Container(
            height: 40,
            decoration: BoxDecoration(
              color: deviceState == BluetoothConnectionState.connected
                  ? Colors.red
                  : Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: onTap,
              child: Text(
                deviceState == BluetoothConnectionState.disconnected
                    ? MyDevicesLabels.itemDeviceListConnect
                    : MyDevicesLabels.itemDeviceListDisconnect,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
