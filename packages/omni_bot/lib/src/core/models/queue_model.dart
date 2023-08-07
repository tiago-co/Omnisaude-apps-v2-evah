import 'package:omni_bot/src/core/models/bot_model.dart';
import 'package:omni_bot/src/core/models/user_model.dart';

class QueueModel {
  BotModel? bot;
  UserModel? user;

  QueueModel({this.bot, this.user});

  QueueModel.fromJson(Map<String, dynamic> json) {
    bot = json['bot'] != null ? BotModel.fromJson(json['bot']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bot'] = bot?.toJson();
    data['user'] = user?.toJson();
    return data;
  }
}
