import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/column_details_widget.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/subsection_widget.dart';

class GenericDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> modelData;
  const GenericDetailsWidget({
    Key? key,
    required this.modelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: dataView(modelData),
        ),
      ],
    );
  }
}

List<Widget> dataView(Map<String, dynamic> extraData) {
  List<Widget> extraDataWidgetList = [];

  extraData.forEach((key, value) {
    extraDataWidgetList.add(fieldLayout(key, value));
  });

  return extraDataWidgetList;
}

Widget fieldLayout(String key, dynamic value) {
  switch (value['type']) {
    case 'simple':
      return RowTextFieldWidget(
        label: key,
        value: verifyStringNull(value['value']),
      );
    case 'list':
      return ColumnDetails(
        items: value['value'],
        label: key,
      );
    case 'map':
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SubsectionWidget(
          subtitle: key,
          data: value['value'],
        ),
      );

    default:
      return const SizedBox();
  }
}

String verifyStringNull(String? value) {
  if (value == 'null' || value == null) {
    return 'Não Informado';
  }
  return value;
}
