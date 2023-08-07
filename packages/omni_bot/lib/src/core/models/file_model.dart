import 'dart:io';

import 'package:omni_bot/src/core/enums/file_type_enum.dart';

class FileModel {
  FileType? fileType;
  File? file;
  String? name;
  String? value;
  String? comment;

  FileModel({
    this.fileType,
    this.name,
    this.file,
    this.value,
    this.comment,
  });

  FileModel.fromJson(Map<String, dynamic> json) {
    fileType = fileTypeFromJson(json['fileType']);
    name = json['name'];
    value = json['value'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileType'] = fileType?.toJson;
    data['name'] = name;
    data['value'] = value;
    data['comment'] = comment;
    return data;
  }
}
