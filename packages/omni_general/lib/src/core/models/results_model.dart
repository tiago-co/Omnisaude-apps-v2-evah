class ResultsModel {
  String? previous;
  String? next;
  int? offset;
  int? count;
  int? pageSize;

  ResultsModel({
    this.previous,
    this.next,
    this.offset,
    this.count,
    this.pageSize,
  });

  ResultsModel.fromJson(Map<String, dynamic> json) {
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;
    return data;
  }
}
