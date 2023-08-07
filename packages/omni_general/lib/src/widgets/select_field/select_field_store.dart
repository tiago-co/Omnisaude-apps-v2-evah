import 'package:flutter_triple/flutter_triple.dart';

class SelectFieldStore extends NotifierStore<Exception, List<String>> {
  SelectFieldStore() : super([]);
  // ignore: prefer_typing_uninitialized_variables
  // late final originalList;

  List<String> filterList(String input) {
    final List<String> filteredList = List.from(state);
    return filteredList
        .where((obj) => obj.toLowerCase().contains(input.toLowerCase()))
        .toList();
  }
}
