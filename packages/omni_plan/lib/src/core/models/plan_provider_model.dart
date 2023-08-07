import 'package:omni_general/omni_general.dart' show ResultsModel;

class PlanProviderModel {
  int? idPrestador;
  String? cdPrestador;
  String? nmPrestador;
  String? dsEstabelecimento;
  String? dsTipoPrestador;
  String? dsEspecialidades;
  String? dsLogradouro;
  String? nrEndereco;
  String? dsComplemento;
  String? dsBairro;
  String? dsMunicipio;
  String? dsEstado;
  String? dtAtualizacao;
  bool? isFavorite;

  PlanProviderModel({
    this.idPrestador,
    this.cdPrestador,
    this.nmPrestador,
    this.dsEstabelecimento,
    this.dsTipoPrestador,
    this.dsEspecialidades,
    this.dsLogradouro,
    this.nrEndereco,
    this.dsComplemento,
    this.dsBairro,
    this.dsMunicipio,
    this.dsEstado,
    this.dtAtualizacao,
    this.isFavorite,
  });

  PlanProviderModel.fromJson(Map<String, dynamic> json) {
    idPrestador = json['id_prestador'];
    cdPrestador = json['cd_prestador'];
    nmPrestador = json['nm_prestador'];
    dsEstabelecimento = json['ds_estabelecimento'];
    dsTipoPrestador = json['ds_tipo_prestador'];
    dsEspecialidades = json['ds_especialidades'];
    dsLogradouro = json['ds_logradouro'];
    nrEndereco = json['nr_endereco'];
    dsComplemento = json['ds_complemento'];
    dsBairro = json['ds_bairro'];
    dsMunicipio = json['ds_municipio'];
    dsEstado = json['ds_estado'];
    dtAtualizacao = json['dt_atualizacao'];
    isFavorite = json['favorito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_prestador'] = idPrestador;
    data['cd_prestador'] = cdPrestador;
    data['nm_prestador'] = nmPrestador;
    data['ds_estabelecimento'] = dsEstabelecimento;
    data['ds_tipo_prestador'] = dsTipoPrestador;
    data['ds_especialidades'] = dsEspecialidades;
    data['ds_logradouro'] = dsLogradouro;
    data['nr_endereco'] = nrEndereco;
    data['ds_complemento'] = dsComplemento;
    data['ds_bairro'] = dsBairro;
    data['ds_municipio'] = dsMunicipio;
    data['ds_estado'] = dsEstado;
    data['dt_atualizacao'] = dtAtualizacao;
    data['favorito'] = isFavorite;
    return data;
  }
}

class PlanProviderResultsModel extends ResultsModel {
  late List<PlanProviderModel> results;

  PlanProviderResultsModel({this.results = const []});

  PlanProviderResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<PlanProviderModel>.empty(growable: true);
      json['results'].forEach(
        (v) => results.add(PlanProviderModel.fromJson(v)),
      );
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
    data['results'] = results.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
