import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/repositories/measurement_historic_repository.dart';
import 'package:omni_measurement/src/measurement_historic/pages/details_measurement_page.dart';
import 'package:omni_measurement/src/measurement_historic/pages/measurement_historic_page.dart';
import 'package:omni_measurement/src/measurement_historic/stores/measurement_date_filter_store.dart';
import 'package:omni_measurement/src/measurement_historic/stores/measurement_historic_store.dart';

class MeasurementHistoricModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MeasurementHistoricStore()),
    Bind.lazySingleton((i) => MeasurementHistoricDateFilterStore()),
    Bind.lazySingleton(
      (i) => MeasumentHistoricRepository(i.get<DioHttpClientImpl>()),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => MeasurementHistoricPage(
        moduleName: args.data,
      ),
    ),
    ChildRoute(
      '/measurement_details',
      child: (_, args) => DetailsMeasurementPage(
        measurement: args.data,
      ),
    ),
  ];
}
