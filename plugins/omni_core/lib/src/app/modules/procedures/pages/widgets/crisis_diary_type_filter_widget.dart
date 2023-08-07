import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_type_filter_store.dart';
import 'package:procedures_labels/labels.dart';

class CrisisDiaryTypeFilterWidget extends StatefulWidget {
  final PageController pageController;

  const CrisisDiaryTypeFilterWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _CrisisDiaryTypeFilterWidgetState createState() =>
      _CrisisDiaryTypeFilterWidgetState();
}

class _CrisisDiaryTypeFilterWidgetState
    extends State<CrisisDiaryTypeFilterWidget> {
  final CrisisDiaryTypeFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TripleBuilder(
            store: store,
            builder: (_, triple) {
              return Opacity(
                opacity: triple.isLoading ? 0.5 : 1.0,
                child: CupertinoSlidingSegmentedControl(
                  children: {
                    0: _buildSchedulingType(ProceduresLabels.crisisDiaryTypeFilterDiary, store.state == 0),
                    1: _buildSchedulingType(ProceduresLabels.crisisDiaryTypeFilterHistoric, store.state == 1),
                  },
                  groupValue: store.state,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(
                        0.1,
                      ),
                  thumbColor: Theme.of(context).primaryColor,
                  onValueChanged: triple.isLoading
                      ? (int? value) => value
                      : (int? value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          widget.pageController.animateToPage(
                            value ?? 0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.decelerate,
                          );
                          store.onValueChanged(value);
                        },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSchedulingType(String label, bool isActive) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      child: Tooltip(
        message: label,
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: isActive ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: isActive ? FontWeight.w600 : null,
              ),
        ),
      ),
    );
  }
}
