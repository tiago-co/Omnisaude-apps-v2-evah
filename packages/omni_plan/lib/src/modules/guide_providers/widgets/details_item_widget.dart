import 'package:flutter/material.dart';
import 'package:guide_providers_labels/labels.dart';

class DetailsItemWidget extends StatelessWidget {
  final String label;
  final String? value;
  const DetailsItemWidget({
    Key? key,
    required this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 8,
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          Flexible(
            flex: 14,
            child: Text(
              value ?? GuideProvidersLabels.detailsItemEmptyValue,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 40,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
