import 'package:omni_general/omni_general.dart';

import 'package:omni_plan/src/core/enums/requisition_status_enum.dart';

class RefundRequestModel {
  String? requestSequenceNumber;
  // RefundRequestStatusType? requestStatus;
  RequisitionStatus? requisitionStatus;
  String? requestDate;

  RefundRequestModel({
    this.requestSequenceNumber,
    // this.requestStatus,
    this.requisitionStatus,
    this.requestDate,
  });

  RefundRequestModel.fromJson(Map<String, dynamic> json) {
    requestSequenceNumber = json['nr_seq_requisicao'];
    // requestStatus =
    //     refundRequestStatusTypeFromJson(json['ds_status_requisicao']);
    requisitionStatus = requisitionStatusFromJson(json['ds_status_requisicao']);
    requestDate = json['dt_requisicao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nr_seq_requisicao'] = requestSequenceNumber;
    // data['ds_status_requisicao'] = requestStatus?.toJson;
    data['ds_status_requisicao'] = requisitionStatus?.toJson;
    data['dt_requisicao'] = requestDate;
    return data;
  }
}

class RefundRequestResultsModel extends ResultsModel {
  List<RefundRequestModel>? results;

  RefundRequestResultsModel({this.results});

  RefundRequestResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<RefundRequestModel>.empty(growable: true);
      json['results']
          .forEach((v) => results!.add(RefundRequestModel.fromJson(v)));
    }
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results?.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
