import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/enums/requisition_status_enum.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_store.dart';

class RefundRequestStatusFilterStore
    extends NotifierStore<Exception, RequisitionStatus> {
  final RefundRequestStore requestStore = Modular.get();

  RefundRequestStatusFilterStore() : super(RequisitionStatus.all);

  Future<void> onChangeStatus(RequisitionStatus status) async {
    update(status);
    requestStore.params.requestStatus = status.toJson;
    requestStore.getAllRefundRequest();
  }
}
