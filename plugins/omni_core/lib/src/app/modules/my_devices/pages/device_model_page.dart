import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/widgets/card_device_widget.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

class DeviceModelPage extends StatefulWidget {
  final MyDevicesStore myDevicesStore;
  const DeviceModelPage({
    Key? key,
    required this.myDevicesStore,
  }) : super(key: key);

  @override
  _DeviceModelPageState createState() => _DeviceModelPageState();
}

class _DeviceModelPageState extends State<DeviceModelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(title: MyDevicesLabels.deviceModelTitle)
          .build(context) as AppBar,
      body: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            widget.myDevicesStore.state.measurementType!.typeDevice.length,
            (index) {
              return CardDeviceWidget(
                title: widget.myDevicesStore.state.measurementType!
                    .typeDevice[index].label,
                asset: widget.myDevicesStore.state.measurementType!
                    .typeDevice[index].asset,
                isImage: true,
                package: AssetsPackage.omniMeasurement,
                onTap: () {
                  widget.myDevicesStore.state.deviceModelType = widget
                      .myDevicesStore.state.measurementType!.typeDevice[index];
                  // widget.myDevicesStore.searchDeviceStore.searchDevices(
                  //   widget.myDevicesStore.state.deviceModelType!,
                  // );
                  Modular.to.pushNamed(
                    'devices_management',
                    arguments: {
                      'myDevicesStore': widget.myDevicesStore,
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
