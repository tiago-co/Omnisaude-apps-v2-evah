import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';

import 'package:omni_scheduling/src/shared/stores/professional_status_store.dart';

class SchedulingDetailsStore extends NotifierStore<Exception, SchedulingModel>
    with Disposable {
  final SchedulingDetailsRepository _repository = Modular.get();
  final ProfessionalStatusStore professionalStore = Modular.get();

  SchedulingDetailsStore() : super(SchedulingModel());

  Future<void> getSchedulingById(String id) async {
    setLoading(true);
    await _repository.getSchedulingById(id).then((scheduling) {
      update(scheduling);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception(onError));
    });
  }

  Future<void> updateSchedulingById(String id, Map<String, String> data) async {
    setLoading(true);
    await _repository.updateSchedulingById(id, data).then((scheduling) {
      update(scheduling);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception(onError));
    });
  }

  @override
  void dispose() {
    professionalStore.dispose();
    _repository.dispose();
  }
}
