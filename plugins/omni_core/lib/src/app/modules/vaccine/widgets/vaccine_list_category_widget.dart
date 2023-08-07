import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/vaccine_model.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notification_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/vaccine/vaccine_store.dart';
import 'package:omni_core/src/app/modules/vaccine/widgets/vaccine_card_category_widget.dart';

class VaccineListCategoryWidget extends StatefulWidget {
  const VaccineListCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  _VaccineTypeWidgetState createState() => _VaccineTypeWidgetState();
}

class _VaccineTypeWidgetState extends State<VaccineListCategoryWidget> {
  final VaccineStore store = Modular.get();

  @override
  void initState() {
    store.getVaccines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<VaccineStore, Exception, List<VaccineModel>>(
      store: store,
      builder: (_, triple) {
        if (store.isLoading) {
          return const NotificationItemShimmerWidget();
        } else {
          return ListView.builder(
            itemCount: store.state.length,
            itemBuilder: (BuildContext context, int index) {
              return VaccineCardCategoryWidget(
                vaccineModel: store.state[index],
              );
            },
          );
        }
      },
    );
  }
}
