import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/item_status_requisition_enum.dart';

import 'package:omni_plan/src/core/enums/requisition_status_enum.dart';

class RefundRequestItemModel {
  int? lineId;
  int? itemTypeId;
  int? itemId;
  String? requestSequenceNumber;
  int? releasedQuantity;
  int? requestedQuantity;
  String? itemCode;
  String? itemDescription;
  String? denialReasonDescription;
  ItemStatusRequisition? itemStatusDescription;
  RequisitionStatus? requestStatusDescription;
  String? requestDate;

  RefundRequestItemModel({
    this.lineId,
    this.itemTypeId,
    this.itemId,
    this.requestSequenceNumber,
    this.releasedQuantity,
    this.requestedQuantity,
    this.itemCode,
    this.itemDescription,
    this.denialReasonDescription,
    this.itemStatusDescription,
    this.requestStatusDescription,
    this.requestDate,
  });

  RefundRequestItemModel.fromJson(Map<String, dynamic> json) {
    lineId = json['id_linha'];
    itemTypeId = json['id_tipo_item'];
    itemId = json['id_item'];
    requestSequenceNumber = json['nr_seq_requisicao'];
    releasedQuantity = json['qt_liberada'];
    requestedQuantity = json['qt_solicitada'];
    itemCode = json['cd_item'];
    itemDescription = json['ds_item'];
    denialReasonDescription = json['ds_motivo_negativa'];

    itemStatusDescription =
        itemStatusRequisitionFromJson(json['ds_status_item']);
    requestStatusDescription =
        requisitionStatusFromJson(json['ds_status_requisicao']);
    requestDate = json['dt_requisicao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_linha'] = lineId;
    data['id_tipo_item'] = itemTypeId;
    data['id_item'] = itemId;
    data['nr_seq_requisicao'] = requestSequenceNumber;
    data['qt_liberada'] = releasedQuantity;
    data['qt_solicitada'] = requestedQuantity;
    data['cd_item'] = itemCode;
    data['ds_item'] = itemDescription;
    data['ds_motivo_negativa'] = denialReasonDescription;
    data['ds_status_item'] = itemStatusDescription?.toJson;
    data['ds_status_requisicao'] = requestStatusDescription?.toJson;
    data['dt_requisicao'] = requestDate;
    return data;
  }
}

class RefundRequestItemResultsModel extends ResultsModel {
  List<RefundRequestItemModel>? results;

  RefundRequestItemResultsModel({this.results});

  RefundRequestItemResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<RefundRequestItemModel>.empty(growable: true);
      json['results']
          .forEach((v) => results!.add(RefundRequestItemModel.fromJson(v)));
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
