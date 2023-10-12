import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';

class SelectFieldItemWidget<T> extends StatelessWidget {
  final ValueChanged<T> onSelectItem;
  final String label;
  final T item;

  const SelectFieldItemWidget({
    Key? key,
    required this.onSelectItem,
    required this.item,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          onSelectItem.call(item);
          FocusScope.of(context).requestFocus(FocusNode());
          Modular.to.pop();
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
      ),
    );
  }
}
