import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';

import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_store.dart';

class SchedulingDetailsChangeDateStore extends NotifierStore<DioError, String>
    with Disposable {
  final SchedulingDetailsStore detailsStore = Modular.get();
  final SchedulingParamsModel params = SchedulingParamsModel();
  final SchedulingDetailsRepository _repository = Modular.get();

  SchedulingDetailsChangeDateStore() : super('');

  Future<void> updateSchedulingById(String id, Map<String, String> data) async {
    setLoading(true);
    await _repository.updateSchedulingById(id, data).then((scheduling) {
      final SchedulingModel oldScheduling = SchedulingModel.fromJson(
        detailsStore.state.toJson(),
      );
      oldScheduling.startDate = scheduling.startDate;
      oldScheduling.status = scheduling.status;
      oldScheduling.type = scheduling.type;
      oldScheduling.oldId = oldScheduling.id;
      oldScheduling.id = scheduling.id;
      detailsStore.getSchedulingById(scheduling.id!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  bool get isDisabled => state.isEmpty;

  @override
  void dispose() {
    _repository.dispose();
  }
}
