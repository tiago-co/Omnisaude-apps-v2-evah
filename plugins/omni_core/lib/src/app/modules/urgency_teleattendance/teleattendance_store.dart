import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TeleattendanceStore extends NotifierStore<DioError, bool> {
  TeleattendanceStore() : super(false) {
    getDailyPassword();
  }

  final String dailyPasswordUrl = dotenv.env['CHAT_DAILY_PASSWORD']!;

  String webViewUrl = dotenv.env['CHAT_WEB_VIEW']!;

  Future<void> getDailyPassword() async {
    setLoading(true);
    final result = await Dio(
      BaseOptions(
        headers: {'Authorization': 'f8deal91-6dhd-48sc-a7de-3267ff77d27'},
      ),
    ).get(
      dailyPasswordUrl,
    );
    final String password = result.data;
    webViewUrl = webViewUrl.replaceAll('@@', password);
    // webViewUrl += webViewUrl + '';
    setLoading(false);
  }
}
// plano, nome da pessoa, CPF, telefone e e-mail