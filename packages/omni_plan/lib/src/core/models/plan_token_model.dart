class PlanTokenModel {
  String? token;
  int? timeLeft;
  int? timeTotal;

  PlanTokenModel({
    this.token,
    this.timeLeft,
    this.timeTotal,
  });

  PlanTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    timeLeft = json['tempo_restante'];
    timeTotal = json['tempo_maximo_validade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['tempo_restante'] = timeLeft;
    data['tempo_maximo_validade'] = timeTotal;

    return data;
  }
}
