import 'package:flutter/material.dart';

import 'package:omni_general/omni_general.dart';

class DiscountInfoWidget extends StatefulWidget {
  const DiscountInfoWidget({Key? key, required this.info}) : super(key: key);
  final DiscountInfo info;
  @override
  State<DiscountInfoWidget> createState() => _DiscountInfoWidgetState();
}

class _DiscountInfoWidgetState extends State<DiscountInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ...widget.info.body
            .map<Row>(
              (e) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('• '),
                  Expanded(
                    child: Text(
                      e,
                      style: const TextStyle(
                        height: 1.75,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff696969),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ]),
    );
  }
}

class UnorderedList extends StatelessWidget {
  UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
