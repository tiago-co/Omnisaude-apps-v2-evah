import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/coparticipation_extract_repository.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/coparticipation_extract_page.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/details_item_extract_page.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/period_extract_page.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/extract_pdf_store.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/item_extract_store.dart';

class CoparticipationExtractModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CoparticipationExtractStore()),
    Bind.lazySingleton((i) => ItemExtractStore()),
    Bind.lazySingleton((i) => ExtractPdfStore()),
    Bind.lazySingleton(
      (i) => CoparticipationExtractRepository(
        i.get<DioHttpClientImpl>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const CoparticipationExtractPage(),
    ),
    ChildRoute(
      '/period_extract',
      child: (_, args) => const PeriodExtractPage(),
    ),
    ChildRoute(
      '/details_item',
      child: (_, args) => DetailsItemExtractPage(
        idExtract: args.data,
      ),
    ),
  ];
}
