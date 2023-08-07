import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';

class DeviceListItemWidget extends StatefulWidget {
  final BluetoothDevice device;
  final MeasurementType? measurementType;
  final Function()? onTap;
  const DeviceListItemWidget({
    Key? key,
    required this.device,
    required this.measurementType,
    this.onTap,
  }) : super(key: key);

  @override
  State<DeviceListItemWidget> createState() => _DeviceListItemWidgetState();
}

class _DeviceListItemWidgetState extends State<DeviceListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothConnectionState>(
      stream: widget.device.connectionState,
      initialData: BluetoothConnectionState.disconnected,
      builder: (c, snapshot) {
        final deviceState = snapshot.data;
        return ListTile(
          onTap: widget.onTap,
          title: Text(
            widget.device.name,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            deviceState == BluetoothConnectionState.disconnected
                ? 'Desconectado'
                : 'Conectado',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: deviceState == BluetoothConnectionState.disconnected
                  ? Colors.red.withOpacity(0.85)
                  : Colors.green.withOpacity(0.85),
              // borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 6,
                color: deviceState == BluetoothConnectionState.disconnected
                    ? Colors.red
                    : Colors.green,
              ),
            ),
            child: const Icon(
              Icons.bluetooth,
              color: Colors.white,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
