import 'dart:convert';

class BankModel {
  String? id;
  String? name;
  String? code;
  BankModel({
    this.id,
    this.name,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'codigo': code,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      id: map['id'],
      name: map['nome'],
      code: map['codigo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source));
}

class BanksListResultsModel {
  List<BankModel>? results;
  String? previous;
  String? next;
  int? offset;
  int? count;
  int? pageSize;

  BanksListResultsModel({
    this.results,
    this.previous,
    this.next,
    this.offset,
    this.count,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'results': results?.map((x) => x.toMap()).toList(),
      'previous': previous,
      'next': next,
      'offset': offset,
      'count': count,
      'pageSize': pageSize,
    };
  }

  factory BanksListResultsModel.fromMap(Map<String, dynamic> map) {
    return BanksListResultsModel(
      results: map['results'] != null
          ? List<BankModel>.from(
              map['results']?.map((x) => BankModel.fromMap(x)),
            )
          : null,
      previous: map['previous'],
      next: map['next'],
      offset: map['offset']?.toInt(),
      count: map['count']?.toInt(),
      pageSize: map['pageSize']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BanksListResultsModel.fromJson(String source) =>
      BanksListResultsModel.fromMap(json.decode(source));
}
