import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class ModuleCategoryStore extends NotifierStore<Exception, ModuleCategoryType> {
  ModuleCategoryStore() : super(ModuleCategoryType.diagnosis);

  void categoryOpened(ModuleCategoryType category) {
    update(category);
  }
}
