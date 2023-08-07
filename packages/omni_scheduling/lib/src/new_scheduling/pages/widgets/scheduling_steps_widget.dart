import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_step_enum.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/scheduling_bottom_button_store.dart';

class SchedulingStepsWidget extends StatefulWidget {
  final PageController pageController;
  final List<SchedulingStepType> steps;

  const SchedulingStepsWidget({
    Key? key,
    required this.steps,
    required this.pageController,
  }) : super(key: key);

  @override
  _SchedulingStepsWidgetState createState() => _SchedulingStepsWidgetState();
}

class _SchedulingStepsWidgetState extends State<SchedulingStepsWidget> {
  final ScrollController scrollController = ScrollController();
  final NewSchedulingStore store = Modular.get();
  final SchedulingBottomButtonStore buttonStore = Modular.get();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.steps
                  .map(
                    (step) => _buildSchedulingStepItem(
                      context,
                      step,
                      isLast: step == widget.steps.last,
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 15),
          if (widget.steps.isNotEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(height: 0),
            ),
        ],
      ),
    );
  }

  Widget _buildSchedulingStepItem(
    BuildContext context,
    SchedulingStepType step, {
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: () {
        const Duration duration = Duration(milliseconds: 250);
        if (!store.state.mediktor!) {
          switch (step) {
            case SchedulingStepType.schedulingCategory:
              store.state.category = null;
              store.state.specialty = null;
              store.state.professionalId = null;
              store.state.date = null;
              store.state.hour = null;
              store.state.reason = '';
              store.update(store.state);
              widget.pageController.animateToPage(
                0,
                duration: duration,
                curve: Curves.decelerate,
              );
              break;
            case SchedulingStepType.schedulingProfessional:
              store.state.reason = '';
              store.update(store.state);
              widget.pageController.animateToPage(
                1,
                duration: duration,
                curve: Curves.decelerate,
              );
              break;
            case SchedulingStepType.schedulingObservation:
              widget.pageController.animateToPage(
                2,
                duration: duration,
                curve: Curves.decelerate,
              );
              break;
          }
        } else {
          switch (step) {
            case SchedulingStepType.schedulingProfessional:
              store.state.reason = '';
              store.update(store.state);
              widget.pageController.animateToPage(
                0,
                duration: duration,
                curve: Curves.decelerate,
              );
              break;
            case SchedulingStepType.schedulingObservation:
              widget.pageController.animateToPage(
                1,
                duration: duration,
                curve: Curves.decelerate,
              );
              break;
            case SchedulingStepType.schedulingCategory:
              break;
          }
        }
      },
      child: Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
        child: Row(
          children: [
            Text(
              step.label,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                Assets.arrowRight,
                height: 13,
                width: 13,
                package: AssetsPackage.omniGeneral,
                color: Theme.of(context).primaryColor.withOpacity(0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
