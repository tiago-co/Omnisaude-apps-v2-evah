class BeneficiaryVeraCruzModel {
  String? nrRegistration;
  String? nrCPF;
  String? name;
  String? birthDate;
  String? genre;
  String? nrPhone;
  String? email;
  String? pspCode;

  BeneficiaryVeraCruzModel({
    this.nrRegistration,
    this.nrCPF,
    this.name,
    this.birthDate,
    this.genre,
    this.nrPhone,
    this.email,
    this.pspCode,
  });

  BeneficiaryVeraCruzModel.fromJson(Map<String, dynamic> json) {
    nrRegistration = json['cd_usuario_plano'];
    nrCPF = json['nr_cpf'];
    name = json['nm_pessoa_fisica'];
    birthDate = json['dt_nascimento'];
    genre = json['ie_sexo'];
    nrPhone = json['nr_telefone_celular'];
    email = json['ds_email'];
    pspCode = json['codigo_psp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cd_usuario_plano'] = nrRegistration;
    data['nr_cpf'] = nrCPF;
    data['nm_pessoa_fisica'] = name;
    data['dt_nascimento'] = birthDate;
    data['ie_sexo'] = genre;
    data['nr_telefone_celular'] = nrPhone;
    data['ds_email'] = email;
    data['codigo_psp'] = pspCode;
    return data;
  }
}
