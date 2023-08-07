import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_triple/flutter_triple.dart';

class SliderPresentationStore extends NotifierStore<Exception, int> {
  SliderPresentationStore() : super(0);

  Future<void> onChangeSliderSelected(
    int index,
    CarouselPageChangedReason reason,
  ) async {
    update(index);
  }
}
