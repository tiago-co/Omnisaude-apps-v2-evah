import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_store.dart';

// ignore: must_be_immutable
class RefundRequestDateFilterStore extends NotifierStore<Exception, DateTime> {
  final RefundRequestStore requestStore = Modular.get();

  RefundRequestDateFilterStore() : super(DateTime.now());

  bool isDateSelected = false;

  Future<void> onChangeStatus(DateTime selectedDate) async {
    update(DateUtils.dateOnly(selectedDate));
    requestStore.params.requestDate =
        Formaters.dateToStringDateWithHifen(selectedDate);
    await requestStore.getAllRefundRequest();
  }
}
