import 'package:extra_data_labels/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_type_store.dart';

class ExtraDataTypeFilterWidget extends StatefulWidget {
  final PageController pageController;

  const ExtraDataTypeFilterWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _ExtraDataTypeFilterWidgetState createState() =>
      _ExtraDataTypeFilterWidgetState();
}

class _ExtraDataTypeFilterWidgetState extends State<ExtraDataTypeFilterWidget> {
  final ExtraDataTypeStore store = Modular.get();
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
                    0: _buildSchedulingType(
                        ExtraDataLabels.extraDataTypeFilterForm,
                        store.state == 0),
                    1: _buildSchedulingType(
                        ExtraDataLabels.extraDataTypeFilterHistoric,
                        store.state == 1),
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
