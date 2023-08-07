import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_date_filter_store.dart';

class SchedulingDateFilterWidget extends StatefulWidget {
  const SchedulingDateFilterWidget({Key? key}) : super(key: key);

  @override
  _SchedulingDateFilterWidgetState createState() =>
      _SchedulingDateFilterWidgetState();
}

class _SchedulingDateFilterWidgetState
    extends State<SchedulingDateFilterWidget> {
  final SchedulingDateFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<SchedulingDateFilterStore, DioError, DateTime>(
      store: store,
      builder: (_, triple) {
        return DateFilterWidget(
          date: triple.state,
          isLoading: triple.isLoading,
          nextMonth: store.nextMonth,
          previousMonth: store.previousMonth,
        );
      },
    );
  }
}
