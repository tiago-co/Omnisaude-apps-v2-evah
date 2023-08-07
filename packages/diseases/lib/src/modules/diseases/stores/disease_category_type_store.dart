import 'package:flutter_triple/flutter_triple.dart';

class DiseaseCategoryTypeStore extends NotifierStore<Exception, String> {
  DiseaseCategoryTypeStore() : super('');

  void updateForm(String type) {
    update(type);
  }
}
