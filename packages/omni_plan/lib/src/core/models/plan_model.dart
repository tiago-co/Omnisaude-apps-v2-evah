class PlanModel {
  String? id;
  String? name;
  String? ansRegister;
  String? register;

  PlanModel({this.id, this.name, this.ansRegister, this.register});

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    ansRegister = json['registro_ans'];
    register = json['registro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['registro_ans'] = ansRegister;
    data['registro'] = register;
    return data;
  }
}
