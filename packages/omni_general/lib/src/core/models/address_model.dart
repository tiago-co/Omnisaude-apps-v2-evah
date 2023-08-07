class AddressModel {
  String? id;
  String? city;
  String? district;
  String? state;
  String? zipCode;
  String? street;
  String? complement;

  AddressModel({
    this.id,
    this.city,
    this.district,
    this.state,
    this.zipCode,
    this.street,
    this.complement,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['cidade'];
    district = json['bairro'];
    state = json['uf'];
    zipCode = json['cep'];
    street = json['logradouro'];
    complement = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cidade'] = city;
    data['bairro'] = district;
    data['uf'] = state;
    data['cep'] = zipCode;
    data['logradouro'] = street;
    data['complemento'] = complement;
    if (complement == null) {
      data['complemento'] = '';
    }
    return data;
  }
}

class ViaCepModel {
  String? zipCode;
  String? street;
  String? complement;
  String? district;
  String? city;
  String? uf;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;

  ViaCepModel({
    this.zipCode,
    this.street,
    this.complement,
    this.district,
    this.city,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  });

  ViaCepModel.fromJson(Map<String, dynamic> json) {
    zipCode = json['cep'];
    street = json['logradouro'];
    complement = json['complemento'];
    district = json['bairro'];
    city = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = zipCode;
    data['logradouro'] = street;
    data['complemento'] = complement;
    data['bairro'] = district;
    data['localidade'] = city;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }
}
