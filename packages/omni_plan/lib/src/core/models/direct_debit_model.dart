import 'dart:convert';

class DirectDebitModel {
  int? idBeneficiario;
  String? nrMatricula;
  String? nrCpf;
  String? nmBeneficiario;
  int? cdContrato;
  String? ieTitular;
  String? ieFormaPgtoContrato;
  String? cdBanco;
  String? cdAgenciaBancaria;
  String? ieDigitoAgencia;
  String? nrConta;
  String? nrDigitoConta;
  int? nrSeqPagador;
  String? dtInicio;
  String? dtAtualizacao;
  bool? podeCadatastrarDebitoAutomatico;
  bool? possuiDebitoAutomatico;

  DirectDebitModel({
    this.idBeneficiario,
    this.nrMatricula,
    this.nrCpf,
    this.nmBeneficiario,
    this.cdContrato,
    this.ieTitular,
    this.ieFormaPgtoContrato,
    this.cdBanco,
    this.cdAgenciaBancaria,
    this.ieDigitoAgencia,
    this.nrConta,
    this.nrDigitoConta,
    this.nrSeqPagador,
    this.dtInicio,
    this.dtAtualizacao,
    this.podeCadatastrarDebitoAutomatico,
    this.possuiDebitoAutomatico,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (idBeneficiario != null) {
      result.addAll({'id_beneficiario': idBeneficiario});
    }
    if (nrMatricula != null) {
      result.addAll({'nr_matricula': nrMatricula});
    }
    if (nrCpf != null) {
      result.addAll({'nr_cpf': nrCpf});
    }
    if (nmBeneficiario != null) {
      result.addAll({'nm_beneficiario': nmBeneficiario});
    }
    if (cdContrato != null) {
      result.addAll({'cd_contrato': cdContrato});
    }
    if (ieTitular != null) {
      result.addAll({'ie_titular': ieTitular});
    }
    if (ieFormaPgtoContrato != null) {
      result.addAll({'ie_forma_pgto_contrato': ieFormaPgtoContrato});
    }
    if (cdBanco != null) {
      result.addAll({'cd_banco': cdBanco});
    }
    if (cdAgenciaBancaria != null) {
      result.addAll({'cd_agencia_bancaria': cdAgenciaBancaria});
    }
    if (ieDigitoAgencia != null) {
      result.addAll({'ie_digito_agencia': ieDigitoAgencia});
    }
    if (nrConta != null) {
      result.addAll({'nr_conta': nrConta});
    }
    if (nrDigitoConta != null) {
      result.addAll({'nr_digito_conta': nrDigitoConta});
    }
    if (nrSeqPagador != null) {
      result.addAll({'nr_seq_pagador': nrSeqPagador});
    }
    if (nrSeqPagador != null) {
      result.addAll({'dt_inicio': nrSeqPagador});
    }
    if (nrSeqPagador != null) {
      result.addAll({'dt_atualizacao': nrSeqPagador});
    }
    result.addAll(
      {'pode_cadatastrar_debito_automatico': podeCadatastrarDebitoAutomatico},
    );
    if (possuiDebitoAutomatico != null) {
      result.addAll({'possui_debito_automatico': possuiDebitoAutomatico});
    }

    return result;
  }

  factory DirectDebitModel.fromMap(Map<String, dynamic> map) {
    return DirectDebitModel(
      idBeneficiario: map['id_beneficiario']?.toInt(),
      nrMatricula: map['nr_matricula'],
      nrCpf: map['nr_cpf'],
      nmBeneficiario: map['nm_beneficiario'],
      cdContrato: map['cd_contrato']?.toInt(),
      ieTitular: map['ie_titular'],
      ieFormaPgtoContrato: map['ie_forma_pgto_contrato'],
      cdBanco: map['cd_banco'],
      cdAgenciaBancaria: map['cd_agencia_bancaria'],
      ieDigitoAgencia: map['ie_digito_agencia'],
      nrConta: map['nr_conta'],
      nrDigitoConta: map['nr_digito_conta'],
      nrSeqPagador: map['nr_seq_pagador']?.toInt(),
      dtInicio: map['dt_inicio'],
      dtAtualizacao: map['dt_atualizacao'],
      podeCadatastrarDebitoAutomatico:
          map['pode_cadatastrar_debito_automatico'] ?? false,
      possuiDebitoAutomatico: map['possui_debito_automatico'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectDebitModel.fromJson(String source) =>
      DirectDebitModel.fromMap(json.decode(source));
}
