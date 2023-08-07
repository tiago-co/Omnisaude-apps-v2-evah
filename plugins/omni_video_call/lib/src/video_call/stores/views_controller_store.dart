import 'package:flutter_triple/flutter_triple.dart';

class ViewsControllerStore extends NotifierStore<Exception, int> {
  ViewsControllerStore() : super(1);

  void updateViewsAmount(int viewsAmount) {
    update(viewsAmount, force: true);
  }
}
