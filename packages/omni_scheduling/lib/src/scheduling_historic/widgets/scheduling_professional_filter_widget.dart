import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_professional_filter_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingProfessionalFilterWidget extends StatefulWidget {
  const SchedulingProfessionalFilterWidget({Key? key}) : super(key: key);

  @override
  _SchedulingProfessionalFilterWidgetState createState() =>
      _SchedulingProfessionalFilterWidgetState();
}

class _SchedulingProfessionalFilterWidgetState
    extends State<SchedulingProfessionalFilterWidget> {
  final SchedulingProfessionalFilterStore store = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        store.getProfessionalParams(textController.text);
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
          builder: (_) => _buildProfessionalSheetWidget(_),
        );
      },
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: TripleBuilder<SchedulingProfessionalFilterStore, DioError,
          ProfessionalModel>(
        store: store,
        builder: (_, triple) {
          return Container(
            decoration: BoxDecoration(
              color: triple.state.name != null
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
                  color: triple.state.name != null
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  triple.state.name ??
                      SchedulingLabels.schedulingProfessionalFilterTitle,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: triple.state.name != null
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                ),
                if (triple.state.id != null) const SizedBox(width: 10),
                if (triple.state.id != null)
                  GestureDetector(
                    onTap: () {
                      store.onChangeProfessional(ProfessionalModel());
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
                        SchedulingLabels.schedulingProfessionalFilterClean,
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

  Widget _buildProfessionalSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.only(
        top: 60,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeaderWidget(
                title: SchedulingLabels.schedulingProfessionalFilterSearchTitle,
                controller: textController,
                searchPlaceholder: SchedulingLabels
                    .schedulingProfessionalFilterSearchPlaceholder,
                onSearch: store.getProfessionalParams,
                showSearch: true,
              ),
              Flexible(child: _buildProfesisonalListWidget),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildProfesisonalListWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        if (triple.event == TripleEvent.error) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  physics: const BouncingScrollPhysics(),
                  child: RequestErrorWidget(
                    error: triple.error! as DioError,
                  ),
                ),
              ),
            ],
          );
        }
        if (store.professionals.results!.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!triple.isLoading) const SizedBox(height: 2.5),
              if (triple.isLoading)
                LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  minHeight: 2.5,
                ),
              const SizedBox(height: 15),
              const EmptyWidget(
                message: SchedulingLabels.schedulingProfessionalFilterEmpty,
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!triple.isLoading)
              const SizedBox(
                height: 2.5,
              ),
            if (triple.isLoading)
              LinearProgressIndicator(
                color: Theme.of(context).primaryColor,
                minHeight: 2.5,
              ),
            Flexible(
              child: ListView.builder(
                itemCount: store.professionals.results!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return _buildProfessionalItemWidget(
                    store.professionals.results![index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfessionalItemWidget(ProfessionalModel professional) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          store.onChangeProfessional(professional);
          Modular.to.pop();
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              professional.name ?? '-',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              height: 10,
              width: 10,
              package: AssetsPackage.omniGeneral,
            ),
          ],
        ),
      ),
    );
  }
}
