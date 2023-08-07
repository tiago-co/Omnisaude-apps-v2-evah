import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart' show DateFilterWidget;
import 'package:omni_mediktor/src/mediktor_historic/stores/mediktor_historic_date_filter_store.dart';
import 'package:omni_mediktor/src/mediktor_historic/stores/mediktor_historic_store.dart';

class MediktorHistoricDateFilterWidget extends StatefulWidget {
  const MediktorHistoricDateFilterWidget({Key? key}) : super(key: key);

  @override
  _MediktorHistoricDateFilterWidgetState createState() =>
      _MediktorHistoricDateFilterWidgetState();
}

class _MediktorHistoricDateFilterWidgetState
    extends State<MediktorHistoricDateFilterWidget> {
  final MediktorHistoricStore mediktorHistoricStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<MediktorHistoricDateFilterStore, DioError, DateTime>(
      store: mediktorHistoricStore.mediktorHistoricDateFilterStore,
      builder: (_, triple) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: DateFilterWidget(
            date: triple.state,
            isLoading: triple.isLoading,
            nextMonth: mediktorHistoricStore.nextMonth,
            previousMonth: mediktorHistoricStore.previousMonth,
          ),
        );
      },
    );
  }
}
