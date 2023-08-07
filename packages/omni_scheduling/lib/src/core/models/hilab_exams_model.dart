import 'package:omni_scheduling/src/core/enums/hilab_exam_status.dart';

class HilabExamsModel {
  String? id;
  int? hilabExamId;
  String? name;
  String? reportFile;
  HilabExamStatusType? examStatus;

  HilabExamsModel({
    this.id,
    this.hilabExamId,
    this.name,
    this.reportFile,
    this.examStatus,
  });

  HilabExamsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hilabExamId = json['id_exame_hilab'];
    name = json['nome'];
    examStatus = hilabExamStatusTypeFromJson(json['status']);
    reportFile = json['laudo'];
  }
}
