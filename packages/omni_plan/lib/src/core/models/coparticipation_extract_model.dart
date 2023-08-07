class DateExtract {
  String? date;
  List<CoparticipationExtractModel>? listExtract;

  DateExtract({
    this.date,
    this.listExtract,
  });

  DateExtract.fromJson(Map<String, dynamic> json) {
    date = json.keys.first;
    listExtract = List<CoparticipationExtractModel>.empty(growable: true);
    json[date].forEach(
      (extract) =>
          listExtract!.add(CoparticipationExtractModel.fromJson(extract)),
    );
  }
}

class CoparticipationExtractModel {
  String? idExtratoCopart;
  int? idBeneficiario;
  String? dsEstabelecimento;
  String? cdBeneficiario;
  String? dtReferencia;
  String? cdPrestador;
  String? dsPrestador;
  String? dsTipoItem;
  String? cdItem;
  String? dsItem;
  double? vlCoparticipacao;
  String? dtAtualizacao;

  CoparticipationExtractModel({
    this.idExtratoCopart,
    this.idBeneficiario,
    this.dsEstabelecimento,
    this.cdBeneficiario,
    this.dtReferencia,
    this.cdPrestador,
    this.dsPrestador,
    this.dsTipoItem,
    this.cdItem,
    this.dsItem,
    this.vlCoparticipacao,
    this.dtAtualizacao,
  });

  CoparticipationExtractModel.fromJson(Map<String, dynamic> json) {
    idExtratoCopart = json['id_extrato_copart'];
    idBeneficiario = json['id_beneficiario'];
    dsEstabelecimento = json['ds_estabelecimento'];
    cdBeneficiario = json['cd_beneficiario'];
    dtReferencia = json['dt_referencia'];
    cdPrestador = json['cd_prestador'];
    dsPrestador = json['ds_prestador'];
    dsTipoItem = json['ds_tipo_item'];
    cdItem = json['cd_item'];
    dsItem = json['ds_item'];
    vlCoparticipacao = json['vl_coparticipacao'];
    dtAtualizacao = json['dt_atualizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_extrato_copart'] = idExtratoCopart;
    data['id_beneficiario'] = idBeneficiario;
    data['ds_estabelecimento'] = dsEstabelecimento;
    data['cd_beneficiario'] = cdBeneficiario;
    data['dt_referencia'] = dtReferencia;
    data['cd_prestador'] = cdPrestador;
    data['ds_prestador'] = dsPrestador;
    data['ds_tipo_item'] = dsTipoItem;
    data['cd_item'] = cdItem;
    data['ds_item'] = dsItem;
    data['vl_coparticipacao'] = vlCoparticipacao;
    data['dt_atualizacao'] = dtAtualizacao;
    return data;
  }
}
