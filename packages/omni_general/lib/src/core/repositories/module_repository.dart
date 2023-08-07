import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

class ModuleRepository extends Disposable {
  final DioHttpClientImpl _client;

  ModuleRepository(this._client);

  BaseUrlStore baseUrlStore = Modular.get();

  Future<List<ModuleModel>?> getActiveModules() async {
    _client.setBaseUrl(
      baseUrl: dotenv.env[baseUrlStore.state]! + dotenv.env['API']!,
    );

    try {
      final Response response =
          await _client.get(path: '/mobile/omni/modulo-fase');
      final List<ModuleModel> modules = [];
      response.data.forEach(
        (module) {
          final ModuleModel model = ModuleModel.fromJson(module);
          if (model.type == ModuleType.bot) {
            model.category = ModuleCategoryType.prevent;
          }
          modules.add(model);
        },
      );
      modules.add(
        ModuleModel(
          name: 'Pronto Atendimento Virtual',
          active: true,
          category: ModuleCategoryType.diagnosis,
          type: ModuleType.urgencyAttendance,
          description: 'Pronto Atendimento Virtual',
        ),
      );
      // modules.add(
      //   ModuleModel(
      //     name: 'Desconto em Exames',
      //     active: true,
      //     category: ModuleCategoryType.benefits,
      //     type: ModuleType.examsDiscount,
      //     description: 'Desconto em Exames',
      //   ),
      // );

      return modules;
    } on DioError catch (e) {
      log('getActiveModules: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
