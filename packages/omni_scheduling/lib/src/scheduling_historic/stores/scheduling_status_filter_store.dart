import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_status_enum.dart';

import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';

class SchedulingStatusFilterStore
    extends NotifierStore<Exception, SchedulingStatus> {
  final SchedulingHistoricStore historicStore = Modular.get();

  SchedulingStatusFilterStore() : super(SchedulingStatus.all);

  Future<void> onChangeStatus(SchedulingStatus? status) async {
    update(status!);
    historicStore.params.status = status.toJson;
    historicStore.getSchedules(historicStore.params);
  }
}
