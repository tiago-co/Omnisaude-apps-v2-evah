import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_token_model.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_token_store.dart';
import 'package:omni_plan/src/modules/plan_card/stores/time_left_store.dart';
import 'package:omni_plan/src/modules/plan_card/widgets/single_number_token_widget.dart';
import 'package:plan_card_labels/labels.dart';

class PlanTokenWidget extends StatefulWidget {
  const PlanTokenWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanTokenWidget> createState() => _PlanTokenWidgetState();
}

class _PlanTokenWidgetState extends State<PlanTokenWidget>
    with TickerProviderStateMixin, Disposable {
  final PlanTokenStore tokenStore = Modular.get();
  final TimeLeftStore timeLeftStore = Modular.get();

  late AnimationController controller;
  late Animation<int> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tokenStore.getPlanToken();
    super.initState();
  }

  double coutdownPercent = 1;

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<PlanTokenStore, DioError, PlanTokenModel>(
      store: tokenStore,
      builder: (_, triple) {
        if (!triple.isLoading) {
          controller = AnimationController(
            vsync: this,
            duration: Duration(
              seconds:
                  tokenStore.state.timeLeft ?? (triple.state.timeTotal! - 2),
            ),
          );
          controller.forward();
          animation = StepTween(
            begin: tokenStore.state.timeLeft,
            end: 0,
          ).animate(controller);

          controller.addListener(() {
            timeLeftStore.updateTimer(
              Duration(seconds: animation.value).inSeconds /
                  triple.state.timeTotal!,
            );
          });
        }

        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () => tokenStore.getPlanToken(),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Text(
                PlanCardLabels.planTokenTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              if (triple.isLoading)
                const SizedBox(
                  height: 133,
                  child: LoadingWidget(),
                ),
              if (!triple.isLoading)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SingleNumberToken(
                            number: tokenStore.state.token![0],
                          ),
                          SingleNumberToken(
                            number: tokenStore.state.token![1],
                          ),
                          SingleNumberToken(
                            number: tokenStore.state.token![2],
                          ),
                          SingleNumberToken(
                            number: tokenStore.state.token![3],
                          ),
                          SingleNumberToken(
                            number: tokenStore.state.token![4],
                          ),
                          SingleNumberToken(
                            number: tokenStore.state.token![5],
                          ),
                        ],
                      ),
                    ),
                    TripleBuilder<TimeLeftStore, Exception, double>(
                      store: timeLeftStore,
                      builder: (_, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: LinearProgressIndicator(
                              value: snapshot.state,
                              minHeight: 7,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                        );
                      },
                    ),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 100.0, end: 0.0),
                      duration: Duration(seconds: tokenStore.state.timeLeft!),
                      onEnd: () => tokenStore.getPlanToken(),
                      builder: (context, value, child) {
                        final Duration clockTimer =
                            Duration(seconds: animation.value);
                        final String timerText =
                            '${clockTimer.inMinutes.remainder(60).toString()}:'
                            '${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
                        return Column(
                          children: [
                            Text(
                              timerText,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
            ],
          );
        }
      },
    );
  }
}
