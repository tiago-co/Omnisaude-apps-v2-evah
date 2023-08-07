import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';

class DynamicFormItemStore extends NotifierStore<DioError, DynamicFormModel> {
  DynamicFormItemStore() : super(DynamicFormModel(fields: []));
  final AnswerDynamicFormModel answerForm = AnswerDynamicFormModel(fields: []);

  Future<void> getFields(Function getFields) async {
    setLoading(true);
    await getFields().then((form) {
      answerForm.id = form.id;
      answerForm.fields.clear();
      form.fields?.forEach((field) {
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
      update(form);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }

  Future<void> answerDynamicForm(
    Function(AnswerDynamicFormModel) answerDynamicForm,
    AnswerDynamicFormModel data,
  ) async {
    setLoading(true);
    data.fields.removeWhere((field) => field.value == null);
    await answerDynamicForm(data).then((dynamicForm) {
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

  bool get isDisabled {
    return answerForm.fields.any((field) {
      if (field.isRequired) {
        return field.value == null;
      }
      return false;
    });
  }
}
