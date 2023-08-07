import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BannerStore extends NotifierStore<Exception, String> {
  BannerStore() : super('');

  void updateBannerLabel(String url) {
    if (!dotenv.env['BASE_URL']!.split('.')[0].contains('plataforma')) {
      update(dotenv.env['BASE_URL']!.split('.')[0].substring(8));
    } else {
      update('');
    }
  }
}
