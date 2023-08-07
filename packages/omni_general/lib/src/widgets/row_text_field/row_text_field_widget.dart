import 'package:flutter/material.dart';
import 'package:omni_general/src/widgets/shimmers/input_field_shimmer_widget.dart';

class RowTextFieldWidget extends StatefulWidget {
  final String label;
  final String? value;
  final bool isLoading;
  const RowTextFieldWidget({
    Key? key,
    required this.label,
    this.value,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _RowTextFieldWidgetState createState() => _RowTextFieldWidgetState();
}

class _RowTextFieldWidgetState extends State<RowTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).cardColor,
            width: 0.1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(width: 15),
          if (widget.isLoading)
            const Expanded(child: InputFieldShimmerWidget()),
          if (!widget.isLoading)
            Expanded(
              child: SelectableText(
                widget.value ?? '-',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
