import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BottomNavigationStore extends NotifierStore<Exception, int> {
  BottomNavigationStore() : super(0);
  updatePage(int index) {
    update(index);
  }
}
