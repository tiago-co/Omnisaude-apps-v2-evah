import 'package:flutter_triple/flutter_triple.dart';

class DrugControlTypeFilterStore extends NotifierStore<Exception, int> {
  DrugControlTypeFilterStore() : super(0);

  void onChangeType(int tab) {
    update(tab);
  }
}
