import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart' show Formaters;

import 'package:omni_measurement/src/measurement_historic/stores/measurement_historic_store.dart';

class MeasurementHistoricDateFilterStore
    extends NotifierStore<DioError, DateTime> {
  final MeasurementHistoricStore measurementStore = Modular.get();

  MeasurementHistoricDateFilterStore() : super(DateTime.now());

  Future<DateTime?> nextMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month + 1, state.day);
    measurementStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    measurementStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    measurementStore.params.date = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    ).substring(3);
    update(newDate);
    setLoading(false);

    return measurementStore
        .getMeasurementDays(measurementStore.params, newDate)
        .then((day) {
      final DateTime date = Formaters.stringToDate(
        measurementStore.params.date!,
        format: 'dd/MM/yyyy',
      );
      return date;
    }).catchError(
      (onError) {
        setLoading(false);
        setError(onError);
      },
    );
  }

  Future<DateTime?> previousMonth() async {
    setLoading(true);
    final DateTime newDate = DateTime(state.year, state.month - 1, state.day);
    measurementStore.params.startDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month),
    );
    measurementStore.params.endDate = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    );
    measurementStore.params.date = Formaters.dateToStringDate(
      DateTime(newDate.year, newDate.month + 1, 0),
    ).substring(3);
    update(newDate);
    setLoading(false);
    return measurementStore
        .getMeasurementDays(measurementStore.params, newDate)
        .then((day) {
      final DateTime date = Formaters.stringToDate(
        measurementStore.params.date!,
        format: 'dd/MM/yyyy',
      );
      return date;
    }).catchError(
      (onError) {
        log(onError.toString());
        // setError(onError);
        setLoading(false);
      },
    );
  }
}
