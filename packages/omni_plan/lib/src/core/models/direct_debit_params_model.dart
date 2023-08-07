class DirectDebitParamsModel {
  String? dtInicio;
  String? cdBanco;
  String? cdAgenciaBancaria;
  String? ieDigitoAgencia;
  String? cdConta;
  String? ieDigitoConta;

  DirectDebitParamsModel({
    this.dtInicio,
    this.cdBanco,
    this.cdAgenciaBancaria,
    this.ieDigitoAgencia,
    this.cdConta,
    this.ieDigitoConta,
  });

  DirectDebitParamsModel.fromJson(Map<String, dynamic> json) {
    dtInicio = json['dt_inicio'];
    cdBanco = json['cd_banco'];
    cdAgenciaBancaria = json['cd_agencia_bancaria'];
    ieDigitoAgencia = json['ie_digito_agencia'];
    cdConta = json['cd_conta'];
    ieDigitoConta = json['ie_digito_conta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt_inicio'] = dtInicio;
    data['cd_banco'] = cdBanco;
    data['cd_agencia_bancaria'] = cdAgenciaBancaria;
    data['ie_digito_agencia'] = ieDigitoAgencia;
    data['cd_conta'] = cdConta;
    data['ie_digito_conta'] = ieDigitoConta;
    return data;
  }
}
