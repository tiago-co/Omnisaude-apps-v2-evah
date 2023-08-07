import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/stores/assistance_status_filter_store.dart';
import 'package:omni_assistance/src/core/enums/assistance_status_enum.dart';
import 'package:omni_assistance_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class AssistanceStatusFilterWidget extends StatefulWidget {
  const AssistanceStatusFilterWidget({Key? key}) : super(key: key);

  @override
  State<AssistanceStatusFilterWidget> createState() =>
      _AssistanceStatusFilterWidgetState();
}

class _AssistanceStatusFilterWidgetState
    extends State<AssistanceStatusFilterWidget> {
  final AssistanceStatusFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: _buildStatusSheetWidget,
        );
      },
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: TripleBuilder<AssistanceStatusFilterStore, Exception,
          AssistanceStatus>(
        store: store,
        builder: (_, triple) {
          return Container(
            decoration: BoxDecoration(
              color: triple.state != AssistanceStatus.all
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.filter,
                  package: AssetsPackage.omniGeneral,
                  width: 15,
                  height: 15,
                  color: triple.state != AssistanceStatus.all
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  triple.state != AssistanceStatus.all
                      ? triple.state.label
                      : AssistanceLabels.assistancePageStatus,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: triple.state != AssistanceStatus.all
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                ),
                if (triple.state != AssistanceStatus.all)
                  const SizedBox(width: 10),
                if (triple.state != AssistanceStatus.all)
                  GestureDetector(
                    onTap: () {
                      store.onChangeStatus(AssistanceStatus.all);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        AssistanceLabels.assistancePageClean,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHeaderWidget(title: 'Status'),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: AssistanceStatus.values.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) {
                    return _buildRadioItemWidget(
                      AssistanceStatus.values[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioItemWidget(AssistanceStatus status) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RadioListTile<AssistanceStatus>(
        value: status,
        groupValue: store.state,
        onChanged: (AssistanceStatus? status) async {
          store.onChangeStatus(status);
          Modular.to.pop();
        },
        dense: true,
        activeColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.zero,
        title: Text(
          status.label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
