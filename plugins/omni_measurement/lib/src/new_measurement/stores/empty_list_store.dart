import 'package:flutter_triple/flutter_triple.dart';

class EmptyListStore extends NotifierStore<Exception, bool> {
  EmptyListStore() : super(true);

  void setEmpty(bool value) {
    update(value);
  }
}
