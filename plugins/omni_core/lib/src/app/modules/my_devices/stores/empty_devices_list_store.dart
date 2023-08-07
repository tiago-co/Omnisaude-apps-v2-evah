import 'package:flutter_triple/flutter_triple.dart';

class EmptyDevicesListStore extends NotifierStore<Exception, bool> {
  EmptyDevicesListStore() : super(true);

  void setEmpty(bool value) {
    update(value);
  }
}
