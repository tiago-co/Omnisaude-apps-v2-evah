import 'package:omni_bot/omni_bot.dart';

class UploadFieldModel {
  String? id;
  bool? isRequired;
  String? name;
  String? placeholder;
  FileType? fileType;
  List<String>? customScope;
  String? answer;

  UploadFieldModel({
    this.id,
    this.isRequired,
    this.name,
    this.placeholder,
    this.fileType,
    this.customScope,
    this.answer,
  });

  UploadFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRequired = json['isRequired'];
    name = json['name'];
    placeholder = json['placeholder'];
    fileType = fileTypeFromJson(json['fileType']);
    customScope = json['customScope'].cast<String>();
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isRequired'] = isRequired;
    data['name'] = name;
    data['placeholder'] = placeholder;
    data['fileType'] = fileType?.toJson;
    data['customScope'] = customScope;
    data['answer'] = answer;
    return data;
  }
}
