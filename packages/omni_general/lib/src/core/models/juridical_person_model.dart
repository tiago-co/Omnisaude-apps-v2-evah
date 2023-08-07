class JuridicalPersonModel {
  String? id;
  String? fantasyName;
  String? primaryColor;
  String? logo;

  JuridicalPersonModel({
    this.id,
    this.fantasyName,
    this.primaryColor,
    this.logo,
  });

  JuridicalPersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fantasyName = json['nome_fantasia'];
    primaryColor = json['primary_color'];
    logo = json['logomarca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome_fantasia'] = fantasyName;
    data['primary_color'] = primaryColor;
    data['logomarca'] = logo;
    return data;
  }
}
