import 'dart:convert';

import 'package:omni_plan/src/core/enums/reimbursement_status_enum.dart';
import 'package:omni_plan/src/core/enums/reimbursement_type_enum.dart';

class ReimbursementModel {
  String? id;
  ReimbursementStatus? status;
  String? createdAt;
  ReimbursementType? type;
  ReimbursementModel({
    this.id,
    this.status,
    this.createdAt,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'criado_em': createdAt,
      'status': status!.toJson,
      'tipo': type!.toJson,
    };
  }

  factory ReimbursementModel.fromMap(Map<String, dynamic> map) {
    return ReimbursementModel(
      id: map['id'],
      createdAt: map['criado_em'],
      status: reimbursementStatusFromJson(map['status']),
      type: reimbursementTypeFromJson(map['tipo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReimbursementModel.fromJson(String source) =>
      ReimbursementModel.fromMap(json.decode(source));
}

class ReimbursementListResultsModel {
  List<ReimbursementModel>? results;
  String? previous;
  String? next;
  int? offset;
  int? count;
  int? pageSize;

  ReimbursementListResultsModel({
    this.results,
    this.previous,
    this.next,
    this.offset,
    this.count,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'results': results?.map((x) => x.toMap()).toList(),
      'previous': previous,
      'next': next,
      'offset': offset,
      'count': count,
      'pageSize': pageSize,
    };
  }

  factory ReimbursementListResultsModel.fromMap(Map<String, dynamic> map) {
    return ReimbursementListResultsModel(
      results: map['results'] != null
          ? List<ReimbursementModel>.from(
              map['results']?.map((x) => ReimbursementModel.fromMap(x)),
            )
          : null,
      previous: map['previous'],
      next: map['next'],
      offset: map['offset']?.toInt(),
      count: map['count']?.toInt(),
      pageSize: map['pageSize']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReimbursementListResultsModel.fromJson(String source) =>
      ReimbursementListResultsModel.fromMap(json.decode(source));
}
