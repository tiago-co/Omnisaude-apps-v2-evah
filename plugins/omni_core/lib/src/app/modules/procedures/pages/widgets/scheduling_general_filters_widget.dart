import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_store.dart';

class SchedulingGeneralFiltersWidget extends StatefulWidget {
  const SchedulingGeneralFiltersWidget({Key? key}) : super(key: key);

  @override
  _SchedulingGeneralFiltersWidgetState createState() =>
      _SchedulingGeneralFiltersWidgetState();
}

class _SchedulingGeneralFiltersWidgetState
    extends State<SchedulingGeneralFiltersWidget> {
  final ProceduresStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return AbsorbPointer(
          absorbing: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 0.5,
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                padding: const EdgeInsets.fromLTRB(17.5, 15, 15, 15),
                child: SvgPicture.asset(
                  Assets.filter,
                  color: Theme.of(context).primaryColor,
                  height: 10,
                  package: AssetsPackage.omniGeneral,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
