class Business {
  bool? cashback;
  String? cashbackTransferReceiver;
  int? cashbackRequestableAmount;

  Business({
    this.cashback,
    this.cashbackTransferReceiver,
    this.cashbackRequestableAmount,
  });

  Business.fromJson(Map<String, dynamic> json) {
    cashback = json['cashback'];
    cashbackTransferReceiver = json['cashback_transfer_receiver'];
    cashbackRequestableAmount = json['cashback_requestable_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cashback'] = cashback;
    data['cashback_transfer_receiver'] = cashbackTransferReceiver;
    data['cashback_requestable_amount'] = cashbackRequestableAmount;
    return data;
  }
}