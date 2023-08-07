import 'package:omni_mediktor/src/core/models/bot_model.dart';

class RecommendedBotsModel {
  List<BotModel>? recomendedBots;
  RecommendedBotsModel({this.recomendedBots});

  RecommendedBotsModel.fromJson(Map<String, dynamic> json) {
    if (json['bots'] != null) {
      recomendedBots = <BotModel>[];
      json['bots'].forEach((v) {
        recomendedBots!.add(BotModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recomendedBots != null) {
      data['bots'] = recomendedBots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
