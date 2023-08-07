import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/configure_device_success_page.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/connect_device_page.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/device_model_page.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/devices_management_page.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/my_devices_page.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/pair_device_page.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/empty_devices_list_store.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/scan_new_devices_store.dart';

class MyDevicesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ScanNewDevicestore()),
    Bind.lazySingleton((i) => EmptyDevicesListStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => MyConnectionsPage(
        measurementType: args.data,
      ),
    ),
    ChildRoute(
      '/devices_management',
      child: (_, args) => DevicesManagementPage(
        myDevicesStore: args.data['myDevicesStore'],
      ),
    ),
    ChildRoute(
      '/connect_device',
      child: (_, args) => ConnectDevicePage(
        myDevicesStore: args.data['myDevicesStore'],
      ),
    ),
    ChildRoute(
      '/success_page',
      child: (_, args) => const ConfigureDeviceSuccessPage(),
    ),
    ChildRoute(
      '/pair_device',
      child: (_, args) => PairDevicePage(
        myDevicesStore: args.data['myDevicesStore'],
        connectedDevice: args.data['connectedDevice'],
      ),
    ),
    ChildRoute(
      '/device_model',
      child: (_, args) => DeviceModelPage(
        myDevicesStore: args.data['myDevicesStore'],
      ),
    ),
  ];
}
