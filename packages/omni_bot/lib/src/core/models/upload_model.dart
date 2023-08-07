import 'package:omni_bot/src/core/enums/file_type_enum.dart';

class UploadModel {
  FileType? fileType;
  List<String>? customScope;

  UploadModel({this.fileType, this.customScope});

  UploadModel.fromJson(Map<String, dynamic> json) {
    fileType = fileTypeFromJson(json['fileType']);
    customScope = json['customScope'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileType'] = fileType?.toJson;
    data['customScope'] = customScope;
    return data;
  }
}
