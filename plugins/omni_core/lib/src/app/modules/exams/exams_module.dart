import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_core/src/app/modules/exams/exams_repository.dart';
import 'package:omni_core/src/app/modules/exams/pages/exam_detail_page.dart';
import 'package:omni_core/src/app/modules/exams/pages/exams_page.dart';
import 'package:omni_core/src/app/modules/exams/pages/new_exam_page.dart';
import 'package:omni_core/src/app/modules/exams/stores/exam_store.dart';
import 'package:omni_core/src/app/modules/exams/stores/exams_store.dart';
import 'package:omni_general/omni_general.dart';

class ExamsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ExamStore()),
    Bind.lazySingleton((i) => ExamsStore()),
    Bind.lazySingleton((i) => UploadFileStore()),
    Bind.lazySingleton((i) => ExamsRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ExamsPage(),
    ),
    ChildRoute(
      '/new_exam',
      child: (_, args) => NewExamPage(
        exams: args.data,
      ),
    ),
    ChildRoute(
      '/exam_details',
      child: (_, args) => ExamDetailsPage(
        exams: args.data,
      ),
    ),
  ];
}
