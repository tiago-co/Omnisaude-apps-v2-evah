import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/repositories/measurement_repository.dart';
import 'package:omni_measurement/src/measurement_historic/measurement_historic_module.dart';
import 'package:omni_measurement/src/new_measurement/new_measurement_module.dart';
import 'package:omni_measurement/src/new_measurement/stores/bluetooth_scan_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/bottom_button_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/camera_preview_flash_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/empty_list_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';

class MeasurementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => MeasurementRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => NewMeasurementStore()),
    Bind.lazySingleton((i) => BottomButtonStore()),
    Bind.lazySingleton((i) => CameraPreviewFlashStore()),
    Bind.lazySingleton((i) => BluetoothScanStore()),
    Bind.lazySingleton((i) => EmptyListStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/historic', module: MeasurementHistoricModule()),
    ModuleRoute('/newMeasurement', module: NewMeasurementModule()),
  ];
}
