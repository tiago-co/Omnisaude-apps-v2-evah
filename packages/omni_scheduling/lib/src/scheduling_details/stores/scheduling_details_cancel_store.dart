import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_store.dart';

class SchedulingDetailsCancelStore extends NotifierStore<Exception, String>
    with Disposable {
  final SchedulingDetailsRepository _repository = Modular.get();
  final SchedulingDetailsStore detailsStore = Modular.get();

  SchedulingDetailsCancelStore() : super('');

  Future<void> cancelScheduling(String id, Map<String, String> data) async {
    setLoading(true);
    await _repository.updateSchedulingById(id, data).then((scheduling) {
      final SchedulingModel _scheduling = SchedulingModel.fromJson(
        detailsStore.state.toJson(),
      );
      _scheduling.cancelReason = scheduling.cancelReason;
      _scheduling.startDate = scheduling.startDate;
      _scheduling.status = scheduling.status;
      _scheduling.type = scheduling.type;
      detailsStore.update(_scheduling);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception(onError));
      throw onError;
    });
  }

  bool get isDisabled => state.isEmpty;

  @override
  void dispose() {
    _repository.dispose();
  }
}
