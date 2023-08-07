import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_date_filter_store.dart';
import 'package:omni_general/omni_general.dart';

class ProceduresDateFilterWidget extends StatefulWidget {
  const ProceduresDateFilterWidget({Key? key}) : super(key: key);

  @override
  _ProceduresDateFilterWidgetState createState() =>
      _ProceduresDateFilterWidgetState();
}

class _ProceduresDateFilterWidgetState
    extends State<ProceduresDateFilterWidget> {
  final ProceduresDateFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ProceduresDateFilterStore, DioError, DateTime>(
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
