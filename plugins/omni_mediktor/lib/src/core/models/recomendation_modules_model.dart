import 'dart:convert';

class RecomendationModulesModel {
  bool bot;
  bool schedule;
  bool informative;
  bool measurement;
  RecomendationModulesModel({
    required this.bot,
    required this.schedule,
    required this.informative,
    required this.measurement,
  });

  Map<String, dynamic> toMap() {
    return {
      'pode_bot': bot,
      'pode_agendamento': schedule,
      'pode_informativo': informative,
      'pode_medicao': measurement,
    };
  }

  factory RecomendationModulesModel.fromMap(Map<String, dynamic> map) {
    return RecomendationModulesModel(
      bot: map['pode_bot'] ?? false,
      schedule: map['pode_agendamento'] ?? false,
      informative: map['pode_informativo'] ?? false,
      measurement: map['pode_medicao'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecomendationModulesModel.fromJson(String source) =>
      RecomendationModulesModel.fromMap(json.decode(source));
}
