class PairedDevicesModel {
  List<String>? td8255List;
  List<String>? nonin3230List;
  List<String>? accuCheckGuideList;
  List<String>? td3128List;
  List<String>? md300c208List;

  PairedDevicesModel({
    this.accuCheckGuideList,
    this.nonin3230List,
    this.td3128List,
    this.td8255List,
    this.md300c208List,
  });

  PairedDevicesModel.fromJson(Map<String, dynamic> json) {
    if (json['accuCheckGuideList'] != null) {
      accuCheckGuideList = List<String>.empty(growable: true);
      json['accuCheckGuideList'].forEach((v) {
        accuCheckGuideList?.add(v.toString());
      });
    }
    if (json['nonin3230List'] != null) {
      nonin3230List = List<String>.empty(growable: true);
      json['nonin3230List'].forEach((v) {
        nonin3230List?.add(v.toString());
      });
    }
    if (json['td3128List'] != null) {
      td3128List = List<String>.empty(growable: true);
      json['td3128List'].forEach((v) {
        td3128List?.add(v.toString());
      });
    }
    if (json['td8255List'] != null) {
      td8255List = List<String>.empty(growable: true);
      json['td8255List'].forEach((v) {
        td8255List?.add(v.toString());
      });
    }

    if (json['md300c208List'] != null) {
      td8255List = List<String>.empty(growable: true);
      json['md300c208List'].forEach((v) {
        md300c208List?.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accuCheckGuideList'] =
        accuCheckGuideList?.map((v) => v.toString()).toList();
    data['nonin3230List'] = nonin3230List?.map((v) => v.toString()).toList();
    data['td3128List'] = td3128List?.map((v) => v.toString()).toList();
    data['td8255List'] = td8255List?.map((v) => v.toString()).toList();
    data['md300c208List'] = md300c208List?.map((v) => v.toString()).toList();
    return data;
  }
}
