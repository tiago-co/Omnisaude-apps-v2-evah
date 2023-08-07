import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:guide_providers_labels/labels.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/show_more/show_more_store.dart';

class ShowMoreWidget extends StatefulWidget {
  final AnimationController animationController;
  final ShowMoreStore showMoreStore;

  const ShowMoreWidget({
    Key? key,
    required this.animationController,
    required this.showMoreStore,
  }) : super(key: key);

  @override
  _ShowMoreWidgetState createState() => _ShowMoreWidgetState();
}

class _ShowMoreWidgetState extends State<ShowMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ShowMoreStore, Exception, bool>(
      store: widget.showMoreStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: () {
            widget.showMoreStore.updateState(!widget.showMoreStore.state);
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              widget.showMoreStore.state
                  ? GuideProvidersLabels.showLess
                  : GuideProvidersLabels.showMore,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 10,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        );
      },
    );
  }
}
