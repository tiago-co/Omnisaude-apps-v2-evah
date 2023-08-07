import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/refund_request_item_model.dart';
import 'package:omni_plan/src/modules/refund_tab_status/refund_tab_status_repository.dart';

class RefundRequestItemsStore
    extends NotifierStore<DioError, RefundRequestItemResultsModel> {
  final RefundTabStatusRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel(limit: '10');

  RefundRequestItemsStore() : super(RefundRequestItemResultsModel(results: []));

  Future<void> getRefundRequestItems(String requestSequenceNumber) async {
    setLoading(true);
    _repository
        .getRefundRequestItems(requestSequenceNumber, params)
        .then((refundRequestItems) {
      update(refundRequestItems);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
