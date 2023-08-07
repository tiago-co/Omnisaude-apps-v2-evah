import 'dart:convert';

class TaxDemonstrativeModel {
  int? idDemonstrativeTax;
  String? program;
  String? registrationNumber;
  String? baseYear;
  double? planValue;
  double? coparticipateValue;
  double? dicountValue;
  int? beneficiaryCount;
  DateTime? lastUpdateDate;
  TaxDemonstrativeModel({
    this.idDemonstrativeTax,
    this.program,
    this.registrationNumber,
    this.baseYear,
    this.planValue,
    this.coparticipateValue,
    this.dicountValue,
    this.beneficiaryCount,
    this.lastUpdateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_demonstrativo_ir': idDemonstrativeTax,
      'ds_estabelecimento': program,
      'nr_matricula': registrationNumber,
      'ds_ano_base': baseYear,
      'vl_mensalidade': planValue,
      'vl_coparticipacao': coparticipateValue,
      'vl_desconto': dicountValue,
      'qt_beneficiarios': beneficiaryCount,
      'dt_atualizacao': lastUpdateDate?.millisecondsSinceEpoch,
    };
  }

  factory TaxDemonstrativeModel.fromMap(Map<String, dynamic> map) {
    return TaxDemonstrativeModel(
      // ignore: avoid_dynamic_calls
      idDemonstrativeTax: map['id_demonstrativo_ir']?.toInt(),
      program: map['ds_estabelecimento'],
      registrationNumber: map['nr_matricula'],
      baseYear: map['ds_ano_base'],
      planValue: map['vl_mensalidade'],
      coparticipateValue: map['vl_coparticipacao'],
      dicountValue: map['vl_desconto'],
      // ignore: avoid_dynamic_calls
      beneficiaryCount: map['qt_beneficiarios']?.toInt(),
      lastUpdateDate: map['dt_atualizacao'] != null
          ? DateTime.tryParse(map['dt_atualizacao'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaxDemonstrativeModel.fromJson(String source) =>
      TaxDemonstrativeModel.fromMap(json.decode(source));
}
