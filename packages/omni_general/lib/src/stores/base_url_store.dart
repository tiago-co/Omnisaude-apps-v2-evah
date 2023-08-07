import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BaseUrlStore extends NotifierStore<Exception, String> {
  BaseUrlStore() : super('BASE_URL');

  void changeToHomol() {
    update('HOMOL_BASE_URL');
  }

  void changeToProd() {
    update('PROD_BASE_URL');
  }

  void changeToDemo() {
    update('DEMO_BASE_URL');
  }

  void changeToImpl() {
    update('IMPL_BASE_URL');
  }

  String get mediktorUrl {
    if (dotenv.env[state]! != dotenv.env['PROD_BASE_URL']) {
      return 'https://homol.mediktor.omnisaude.co';
    } else {
      return 'https://prod.mediktor.omnisaude.co';
    }
  }
}
