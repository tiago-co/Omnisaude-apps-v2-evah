import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:omni_core/src/app/core/constants/html_constants.dart';
import 'package:omni_general/omni_general.dart';

class FAQItemWidget extends StatefulWidget {
  final ScrollController scrollController;
  const FAQItemWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  _FAQItemWidgetState createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final Duration duration = const Duration(milliseconds: 250);
  late final Animation<double> animation;
  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    super.initState();
  }

  List getOffset(GlobalKey key) {
    final dynamic render = key.currentContext!.findRenderObject();
    final Offset childOffset = render.localToGlobal(Offset.zero);
    final Size childSize = render.size!;
    return [childOffset, childSize];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return VerticalTimelineItemWidget(
          child: GestureDetector(
            onTap: () async {
              if (animationController.isCompleted) {
                await animationController.reverse();
              } else {
                // widget.scrollController.animateTo(
                //   0,
                //   duration: duration,
                //   curve: Curves.decelerate,
                // );
                await animationController.forward();
              }
              log(widget.scrollController.position.toString());
              final List offsetBase = getOffset(globalKey);
              final Offset childOffset = offsetBase.first;
              // final Size childSize = offsetBase.last;
              log(childOffset.toString());
            },
            child: ColoredBox(
              color: Colors.transparent,
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Uma dúvida considerável que alguém terá um dia!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: const Divider(),
                    ),
                  ),
                  FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: Html(
                        data: htmlData,
                        shrinkWrap: true,
                        style: {
                          'body': Style(
                              // margin: EdgeInsets.zero,

                              ),
                          'html': Style(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontFamily,
                            color:
                                Theme.of(context).textTheme.titleLarge!.color,

                            // margin: EdgeInsets.zero,
                          )
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
