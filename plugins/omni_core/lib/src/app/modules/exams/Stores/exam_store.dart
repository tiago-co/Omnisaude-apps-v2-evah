import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_core/src/app/modules/exams/exams_repository.dart';
import 'package:omni_core/src/app/modules/exams/stores/exams_store.dart';

class ExamStore extends NotifierStore<DioError, NewExamModel> {
  final ExamsRepository _repository = Modular.get();
  final ExamsStore examsStore = Modular.get();

  ExamStore()
      : super(
          NewExamModel(
            observation: '',
            filename: '',
          ),
        );

  Future<void> createExam(NewExamModel data) async {
    setLoading(true);
    await _repository.createExam(data).then((exam) {
      setLoading(false);
      examsStore.getExams(examsStore.params);
      Modular.to.pop();
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  bool get isDisabled {
    return state.file == null ||
        state.file == '' ||
        state.name == null ||
        state.name == '';
  }

  Future<void> editExam(NewExamModel data, String? id) async {
    log(data.name.toString());
    setLoading(true);
    await _repository.editExam(data, id).then((exam) {
      update(exam);
      examsStore.getExams(examsStore.params);
      Modular.to.pop();
      Modular.to.pop();
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }

  Future<void> getDetailExam(String? id) async {
    setLoading(true);
    await _repository.getDetailExam(id).then((exam) {
      update(exam);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }

  Future<void> removeExam(String? id) async {
    setLoading(true);
    await _repository.removeExam(id).then((value) async {
      examsStore.getExams(examsStore.params);
      Modular.to.pop();
      Modular.to.pop();
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
