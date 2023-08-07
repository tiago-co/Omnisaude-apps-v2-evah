import 'package:flutter/material.dart';

class ColumnDetails extends StatefulWidget {
  final String label;
  final String? value;
  final List<String?> items;

  const ColumnDetails({
    Key? key,
    this.value,
    this.label = '',
    this.items = const [],
  }) : super(key: key);

  @override
  State<ColumnDetails> createState() => _IncomeTaxItemTextFieldState();
}

class _IncomeTaxItemTextFieldState<T> extends State<ColumnDetails> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          widget.label,
          softWrap: false,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).cardColor.withOpacity(0.75),
              ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: widget.items.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              widget.items[index].toString(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        const Divider(),
      ],
    );
  }
}
