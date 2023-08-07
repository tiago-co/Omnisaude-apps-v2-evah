import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/refund_request_model.dart';
import 'package:omni_plan/src/core/models/refund_request_query_params.dart';
import 'package:omni_plan/src/modules/refund_tab_status/refund_tab_status_repository.dart';

class RefundRequestStore
    extends NotifierStore<DioError, RefundRequestResultsModel> with Disposable {
  final RefundTabStatusRepository _repository = Modular.get();
  final RefundRequestQueryParamsModel params =
      RefundRequestQueryParamsModel(limit: '10');

  RefundRequestStore() : super(RefundRequestResultsModel(results: []));
  Timer? _debounce;

  Future<void> getAllRefundRequest() async {
    setLoading(true);
    _repository.getAllRefundRequest(params).then((refundRequisitions) {
      update(refundRequisitions);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getRefundRequestParams(String? requestNumber) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.requestNumber = requestNumber;
      await getAllRefundRequest();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
  }
}
