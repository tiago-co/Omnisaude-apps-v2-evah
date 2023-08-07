import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/procedures/crisis_diary_repository.dart';

import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_historic_store.dart';

class CrisisDiaryStore extends NotifierStore<DioError, DynamicFormModel>
    with Disposable {
  final CrisisDiaryRepository _repository = Modular.get();
  final AnswerDynamicFormModel answerForm = AnswerDynamicFormModel(fields: []);
  final CrisisDiaryHistoricStore historicStore = Modular.get();


  CrisisDiaryStore() : super(DynamicFormModel(fields: []));

  Future<void> getCrisisDiary() async {
    setLoading(true);
    await _repository.getCrisisDiary().then((crisisDiary) {
      answerForm.id = crisisDiary.id;
      answerForm.fields.clear();
      crisisDiary.fields?.forEach((field) {
        answerForm.fields.add(FieldModel(id: field.id));
        switch (field.type) {
          case DynamicFormType.input:
            if (field.inputField!.isRequired!) {
              answerForm.fields.last.isRequired = true;
            }
            break;
          case DynamicFormType.upload:
            if (field.uploadField!.isRequired!) {
              answerForm.fields.last.isRequired = true;
            }
            break;
          case DynamicFormType.select:
            if (field.selectField!.isRequired!) {
              answerForm.fields.last.isRequired = true;
            }
            break;
          default:
            break;
        }
      });
      update(crisisDiary);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> answerCrisisDiary(AnswerDynamicFormModel data) async {
    setLoading(true);
    data.fields.removeWhere((field) => field.value == null);
    await _repository.answerCrisisDiary(data).then((dynamicForm) {
      resetForm();
      setLoading(false);
    }).catchError((onError) {
      resetForm();
      setLoading(false);
      throw onError;
    });
  }

  void resetForm() {
    final List<FieldModel> formFields = answerForm.fields.map((field) {
      field.value = null;
      return field;
    }).toList();
    answerForm.fields.clear();
    answerForm.fields.addAll(formFields);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
