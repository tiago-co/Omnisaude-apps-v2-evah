import 'package:omni_core/src/app/core/enums/dynamic_form_enum.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_field_model.dart';
import 'package:omni_general/omni_general.dart';

class DynamicFormModel {
  String? id;
  String? name;
  String? createdAt;
  String? description;
  DynamicFormStatus? status;
  List<DynamicFormFieldModel>? fields;

  DynamicFormModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.description,
    this.fields,
  });

  DynamicFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    description = json['descricao'];
    createdAt = json['criado_em'];
    status = dynamicFormStatusFromJson(json['status']);
    if (json['campos'] != null) {
      fields = List<DynamicFormFieldModel>.empty(growable: true);
      json['campos'].forEach((v) {
        fields!.add(DynamicFormFieldModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['criado_em'] = createdAt;
    data['descricao'] = description;
    data['status'] = status?.toJson;
    data['campos'] = fields?.map((v) => v.toJson()).toList();
    return data;
  }
}

class DynamicFormResultsModel extends ResultsModel {
  late final List<DynamicFormModel> results;

  DynamicFormResultsModel({this.results = const []});

  @override
  DynamicFormResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<DynamicFormModel>.empty(growable: true);
      json['results'].forEach((v) {
        results.add(DynamicFormModel.fromJson(v));
      });
    }
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
