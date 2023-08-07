
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';

class ExtractBeneficiaryModel {
  List<DateExtract>? coparticipationList;
  num? totalValue;

  ExtractBeneficiaryModel({
    this.coparticipationList,
    this.totalValue,
  });

  ExtractBeneficiaryModel.fromJson(Map<String, dynamic> json) {
    totalValue = json['total'];
    if (json['coparticipacoes'] != null) {
      coparticipationList = List<DateExtract>.empty(growable: true);
      json['coparticipacoes'].forEach(
        (key, extract) =>
            coparticipationList!.add(DateExtract.fromJson({key: extract})),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coparticipacoes'] = coparticipationList;
    data['total'] = totalValue;
    return data;
  }
}
