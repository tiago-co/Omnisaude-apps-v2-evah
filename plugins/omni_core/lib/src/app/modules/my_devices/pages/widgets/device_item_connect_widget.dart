import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:my_devices_labels/labels.dart';

class DeviceItemConnectWidget extends StatefulWidget {
  final BluetoothDevice device;
  final Function()? onTap;
  const DeviceItemConnectWidget({
    Key? key,
    required this.device,
    this.onTap,
  }) : super(key: key);

  @override
  State<DeviceItemConnectWidget> createState() =>
      _DeviceItemConnectWidgetState();
}

class _DeviceItemConnectWidgetState extends State<DeviceItemConnectWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      title: Text(
        widget.device.name,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.bluetooth,
          color: Colors.white,
        ),
      ),
      trailing: StreamBuilder<BluetoothConnectionState>(
        stream: widget.device.connectionState,
        initialData: BluetoothConnectionState.disconnected,
        builder: (c, snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: snapshot.data == BluetoothConnectionState.disconnected
                  ? Colors.red
                  : Colors.green,
            ),
            padding: const EdgeInsets.all(5),
            child: Text(
              snapshot.data == BluetoothConnectionState.disconnected
                  ? MyDevicesLabels.deviceItemConnectDisconnected
                  : MyDevicesLabels.deviceItemConnectConnected,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          );
        },
      ),
    );
  }
}
