import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mime/mime.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement/src/core/enums/feeling_type_enum.dart';
import 'package:omni_measurement/src/core/enums/meal_type_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/core/repositories/measurement_repository.dart';

// ignore: must_be_immutable
class NewMeasurementStore extends NotifierStore<DioError, MeasurementModel>
    with Disposable {
  int categoryStep = 0;
  final MeasurementRepository repository = Modular.get();
  final UserStore userStore = Modular.get();
  final MeasurementHistoricStore historicStore = Modular.get();
  int counterPage = 0;
  int counterButton = 0;
  bool isScanning = false;

  NewMeasurementStore() : super(MeasurementModel());

  void updateForm(MeasurementModel form) {
    update(MeasurementModel.fromJson(form.toJson()));
  }

  void onChangeMeasurementType(
    MeasurementType measurementType,
  ) {
    final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
    form.measurementType = measurementType;
    form.date = DateTime.now().toString();
    update(form);
  }

  void onChangeMeasurementMode(MeasurementMode measurementMode) {
    final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
    form.measurementMode = measurementMode;
    form.date = DateTime.now().toString();
    update(form);
  }

  void onChangeAreYouFeeling(AreYouFeeling areYouFeeling) {
    final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
    form.howAreYouFeeling = areYouFeeling;
    update(form);
  }

  Future<void> createMeasurement(MeasurementModel data) async {
    setLoading(true);
    state.meal ??= state.meal = MealType.indefinido;

    final DatePickerController dateController = DatePickerController();

    await repository.createMeasurement(data).then((measurement) {
      update(measurement);
      historicStore.params.limit = '10';
      final DateTime now = DateTime.now();
      historicStore.params.startDate = Formaters.dateToStringDate(
        DateTime(now.year, now.month),
      );
      historicStore.params.endDate = Formaters.dateToStringDate(
        DateTime(now.year, now.month + 1, 0),
      );
      historicStore.params.date = Formaters.dateToStringDate(now);
      historicStore.getMeasurementDays(historicStore.params, now).then((day) {
        dateController.setDateAndAnimate(
          DateTime(now.year, now.month, day!),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.decelerate,
        );
      });
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
    setLoading(false);
  }

  bool isButtonDisabled(int page, MeasurementModel form) {
    switch (page) {
      case 0:
        return form.measurementType == null;
      case 1:
        return form.measurementType == null || form.measurementMode == null;
      case 2:
        return form.measurementType == null || form.measurementMode == null;
      case 3:
        if (form.measurementMode == MeasurementMode.manual) {
          return form.measurementType == null ||
              form.measurementMode == null ||
              form.currentMeasure == null;
        } else if (form.measurementMode == MeasurementMode.automatic) {
          if (isScanning) {
            return false;
          } else {
            return true;
          }
        }
        return false;
      case 4:
        return form.measurementMode == null ||
            form.currentMeasure == null ||
            form.howAreYouFeeling == null;
      case 5:
        return false;
    }
    return true;
  }

  Future<String> modePicture() async {
    String b64 = '-1';

    final List<CameraDescription> cameras = await availableCameras();
    await Modular.to
        .pushNamed(
      '/home/measurements/newMeasurement/camera',
      arguments: cameras,
    )
        .then((xfile) {
      if (xfile == null) {
        return b64;
      } else {
        final File file = xfile as File;
        final String ext = lookupMimeType(file.path) ?? '';
        b64 = UriData.fromBytes(
          file.readAsBytesSync(),
          mimeType: ext,
        ).toString();
      }
    });

    // await service.openCamera().then(
    //   (file) async {
    //     if (file == null) {
    //       return b64;
    //     } else {
    //       final String text = lookupMimeType(file.path) ?? '';
    //       b64 = UriData.fromBytes(
    //         file.readAsBytesSync(),
    //         mimeType: ext,
    //       ).toString();
    //     }
    //   },
    // );
    return b64;
  }

  Future<void> setCurrentMeasure(String value) async {
    try {
      final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
      form.currentMeasure = value;
      update(form);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMeasurementOCR(String picture) async {
    final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
    setLoading(true);
    repository.sendMeasurementOCR(picture).then((measurement) {
      form.currentMeasure = measurement;
      update(form);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> readConnectedDevices(
    BluetoothDevice device,
    MeasurementType measurementType,
  ) async {
    setLoading(true);
    try {
      String measureInDevice = '';
      final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
      measureInDevice = await repository
          .readConnectedDevices(device, measurementType)
          .catchError(
        (onError) {
          device.disconnect();
          setLoading(false);
          throw onError;
        },
      );

      //tratar erro de medição inválida
      measureInDevice == '127' ||
              measureInDevice == '0' ||
              measureInDevice == ''
          ? throw 'Medição inválida'
          : form.currentMeasure = measureInDevice;

      update(form);
      setLoading(false);
    } catch (e) {
      log('Error ao obter medição via Bluetooth: $e');
      setLoading(false);
      rethrow;
    }
  }

  Future<void> readUnconnectedDevices(
    BluetoothDevice device,
    MeasurementType measurementType,
  ) async {
    setLoading(true);
    try {
      String measureInDevice = '';
      final MeasurementModel form = MeasurementModel.fromJson(state.toJson());
      measureInDevice =
          await repository.connect(device, measurementType).catchError(
        (onError) {
          device.disconnect();
          setLoading(false);
          throw onError;
        },
      );

      //tratar erro de medição inválida
      measureInDevice == '127' ||
              measureInDevice == '0' ||
              measureInDevice == ''
          ? throw 'Medição inválida'
          : form.currentMeasure = measureInDevice;

      update(form);
      setLoading(false);
    } catch (e) {
      log('Error ao obter medição via Bluetooth: $e');
      setLoading(false);
      rethrow;
    }
  }

  @override
  void dispose() {
    repository.dispose();
  }
}
