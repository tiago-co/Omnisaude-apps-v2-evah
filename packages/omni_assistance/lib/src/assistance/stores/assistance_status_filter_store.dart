import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/stores/assistances_store.dart';
import 'package:omni_assistance/src/core/enums/assistance_status_enum.dart';

class AssistanceStatusFilterStore
    extends NotifierStore<Exception, AssistanceStatus> {
  AssistanceStatusFilterStore() : super(AssistanceStatus.all);

  final AssistancesStore assistancesStore = Modular.get();

  Future<void> onChangeStatus(AssistanceStatus? status) async {
    update(status!);
    assistancesStore.params.status = status.toJson;
    assistancesStore.getAssistancesList(assistancesStore.params);
  }
}
