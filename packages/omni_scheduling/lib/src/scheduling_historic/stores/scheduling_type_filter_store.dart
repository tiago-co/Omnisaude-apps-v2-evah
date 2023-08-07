import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';

import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';

class SchedulingTypeFilterStore extends NotifierStore<Exception, int> {
  final SchedulingHistoricStore historicStore = Modular.get();

  SchedulingTypeFilterStore() : super(0);

  Future<void> onValueChanged(int? value) async {
    setLoading(true);
    update(value ?? 0);
    switch (state) {
      case 0:
        historicStore.params.type = null;
        break;
      case 1:
        historicStore.params.type = SchedulingType.presential.toJson;
        break;
      case 2:
        historicStore.params.type = SchedulingType.teleAttendance.toJson;
        break;
    }
    await historicStore.getSchedules(historicStore.params).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
