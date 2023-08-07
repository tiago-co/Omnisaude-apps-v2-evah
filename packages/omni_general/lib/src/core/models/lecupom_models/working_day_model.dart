class WorkingDayModel {
  int? weekDay;
  bool? isAvailable;
  String? startHour;
  String? endHour;

  WorkingDayModel({
    this.endHour,
    this.isAvailable,
    this.startHour,
    this.weekDay,
  });

  WorkingDayModel.fromJson(Map<String, dynamic> json) {
    endHour = json['end_hour'];
    startHour = json['start_hour'];
    isAvailable = json['is_available'];
    weekDay = json['week_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['end_hour'] = endHour;
    data['start_hour'] = startHour;
    data['is_available'] = isAvailable;
    data['week_day'] = weekDay;

    return data;
  }
}
