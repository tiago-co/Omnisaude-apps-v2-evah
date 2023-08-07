import 'package:omni_general/omni_general.dart' show ResultsModel;

class ProfessionalModel {
  String? id;
  String? name;
  String? typeCR;
  String? type;
  String? numberCR;
  String? ufCR;
  String? image;

  ProfessionalModel({
    this.id,
    this.name,
    this.typeCR,
    this.type,
    this.numberCR,
    this.ufCR,
    this.image,
  });

  ProfessionalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    typeCR = json['tipo_cr'];
    type = json['tipo_profissional'];
    numberCR = json['numero_cr'];
    ufCR = json['uf_cr'];
    image = json['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['tipo_cr'] = typeCR;
    data['tipo_profissional'] = type;
    data['numero_cr'] = numberCR;
    data['uf_cr'] = ufCR;
    data['imagem'] = image;
    return data;
  }
}

class ProfessionalResults extends ResultsModel {
  List<ProfessionalModel>? results;

  ProfessionalResults({this.results});

  ProfessionalResults.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<ProfessionalModel>.empty(growable: true);
      json['results']
          .forEach((v) => results!.add(ProfessionalModel.fromJson(v)));
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

class ProfessionalCategoryModel {
  String? type;
  String? labelType;

  ProfessionalCategoryModel({
    this.type,
    this.labelType,
  });

  ProfessionalCategoryModel.fromJson(Map<String, dynamic> json) {
    type = json['tipo'];
    labelType = json['tipo_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tipo'] = type;
    data['tipo_label'] = labelType;
    return data;
  }
}

class ProfessionalAvaliableDaysModel {
  int? day;
  int? month;
  int? year;
  bool? isAvaliable;

  ProfessionalAvaliableDaysModel(
    this.day,
    this.month,
    this.year,
    this.isAvaliable,
  );

  ProfessionalAvaliableDaysModel.fromJson(Map<String, dynamic> json) {
    day = json['dia'];
    month = json['mes'];
    year = json['ano'];
    isAvaliable = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dia'] = day;
    data['status'] = isAvaliable;
    return data;
  }
}
