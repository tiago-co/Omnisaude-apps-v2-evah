import 'dart:convert';

import 'package:omni_plan/src/core/enums/reimbursement_status_enum.dart';
import 'package:omni_plan/src/core/enums/reimbursement_type_enum.dart';
import 'package:omni_plan/src/core/models/bank_model.dart';
import 'package:omni_plan/src/core/models/extra_documents_model.dart';

class ReimbursementDetailsModel {
  String? id;
  BankModel? bank;
  String? agency;
  String? account;
  String? name;
  String? phone;
  String? email;
  ReimbursementType? type;
  ReimbursementStatus? status;
  String? receipt;
  String? invoice;
  String? reason;
  List<ExtraDocumentsModel>? extraDocuments;
  ReimbursementDetailsModel({
    this.id,
    this.bank,
    this.agency,
    this.account,
    this.name,
    this.phone,
    this.email,
    this.type,
    this.status,
    this.receipt,
    this.invoice,
    this.reason,
    this.extraDocuments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'banco': bank?.toMap(),
      'agencia': agency,
      'conta': account,
      'nome': name,
      'telefone': phone,
      'email': email,
      'tipo': type?.toJson,
      'status': status?.toJson,
      'recibo': receipt,
      'nota_fiscal': invoice,
      'motivo': reason,
      'documentos_extras': extraDocuments?.map((x) => x.toMap()).toList(),
    };
  }

  factory ReimbursementDetailsModel.fromMap(Map<String, dynamic> map) {
    return ReimbursementDetailsModel(
      id: map['id'],
      bank: map['banco'] != null ? BankModel.fromMap(map['banco']) : null,
      agency: map['agencia'],
      account: map['conta'],
      name: map['nome'],
      phone: map['telefone'],
      email: map['email'],
      type: map['tipo'] != null ? reimbursementTypeFromJson(map['tipo']) : null,
      status: map['status'] != null
          ? reimbursementStatusFromJson(map['status'])
          : null,
      receipt: map['recibo'],
      invoice: map['nota_fiscal'],
      reason: map['motivo'],
      extraDocuments: map['documentos_extras'] != null
          ? List<ExtraDocumentsModel>.from(
              map['documentos_extras']?.map(
                (x) => ExtraDocumentsModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReimbursementDetailsModel.fromJson(String source) =>
      ReimbursementDetailsModel.fromMap(json.decode(source));
}
