import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/presentation/stores/slider_presentation_store.dart';

class SliderDotsWidget extends StatefulWidget {
  final SliderPresentationStore store;

  const SliderDotsWidget({Key? key, required this.store}) : super(key: key);

  @override
  _SliderDotsWidgetState createState() => _SliderDotsWidgetState();
}

class _SliderDotsWidgetState extends State<SliderDotsWidget> {
  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: widget.store,
      builder: (_, triple) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDotWidget(0, triple.state),
            _buildDotWidget(1, triple.state),
            // _buildDotWidget(2, triple.state),
          ],
        );
      },
    );
  }

  Widget _buildDotWidget(int index, Object? state) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: state == index ? Theme.of(context).primaryColor : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.5,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
