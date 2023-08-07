class BotModel {
  String? id;
  String? nome;
  String? descricao;
  String? idOriginal;
  String? logo;
  bool? atendimentoHumanizado;
  String? categoria;
  bool? importante;

  BotModel({
    this.id,
    this.nome,
    this.descricao,
    this.idOriginal,
    this.atendimentoHumanizado,
    this.categoria,
    this.importante,
    this.logo,
  });

  BotModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    logo = json['logo'];
    idOriginal = json['id_original'];
    atendimentoHumanizado = json['atendimento_humanizado'];
    categoria = json['categoria'];
    importante = json['importante'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['logo'] = logo;
    data['descricao'] = descricao;
    data['id_original'] = idOriginal;
    data['atendimento_humanizado'] = atendimentoHumanizado;
    data['categoria'] = categoria;
    data['importante'] = importante;
    return data;
  }
}
