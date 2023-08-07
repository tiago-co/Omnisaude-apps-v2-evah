import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_measurement/src/new_measurement/pages/camera_preview_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/confirm_photo_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/new_measurement_page.dart';
import 'package:omni_measurement/src/new_measurement/stores/mediktor_measurement_type_store.dart';

class NewMeasurementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MediktorMeasurementTypeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NewMeasurementPage(
        moduleName: args.data['moduleName'],
        specialtyId: args.data['specialtyId'],
      ),
    ),
    ChildRoute(
      '/camera',
      child: (_, args) => CameraPreviewPage(cameras: args.data),
    ),
    ChildRoute(
      '/confirm_photo',
      child: (_, args) => ConfirmPhotoPage(file: args.data),
    ),
  ];
}
