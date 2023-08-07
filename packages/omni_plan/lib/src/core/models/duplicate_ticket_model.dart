import 'dart:convert';

class DuplicateTicketModel {
  String? ticketCode;
  int? monthlyPaymentId;
  String? dueDate;
  String? referenceDate;
  double? monthlyValue;
  String? expiryTime;
  String? ieBoleto;
  DuplicateTicketModel({
    this.ticketCode,
    this.monthlyPaymentId,
    this.dueDate,
    this.referenceDate,
    this.monthlyValue,
    this.expiryTime,
    this.ieBoleto,
  });

  Map<String, dynamic> toMap() {
    return {
      'ds_codigo_boleto': ticketCode,
      'id_mensalidade': monthlyPaymentId,
      'dt_vencimento': dueDate,
      'dt_referencia': referenceDate,
      'vl_mensalidade': monthlyValue,
      'ds_prazo_vencimento': expiryTime,
      'ie_boleto': ieBoleto,
    };
  }

  factory DuplicateTicketModel.fromMap(Map<String, dynamic> map) {
    return DuplicateTicketModel(
      ticketCode: map['ds_codigo_boleto'],
      monthlyPaymentId: map['id_mensalidade'],
      dueDate: map['dt_vencimento'],
      referenceDate: map['dt_referencia'],
      monthlyValue: map['vl_mensalidade'],
      expiryTime: map['ds_prazo_vencimento'],
      ieBoleto: map['ie_boleto'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DuplicateTicketModel.fromJson(String source) =>
      DuplicateTicketModel.fromMap(json.decode(source));
}
