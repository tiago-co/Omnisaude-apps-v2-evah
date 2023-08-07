class OptionModel {
  String? id;
  String? title;
  String? subtitle;
  String? image;

  OptionModel({this.id, this.title, this.subtitle, this.image});

  OptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image'] = image;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          subtitle == other.subtitle &&
          image == other.image;

  @override
  int get hashCode => Object.hash(id, title, subtitle, image);
}
