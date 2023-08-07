import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/specialty_model.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_specialty_filter_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingSpecialtyFilterWidget extends StatefulWidget {
  const SchedulingSpecialtyFilterWidget({Key? key}) : super(key: key);

  @override
  _SchedulingSpecialtyFilterWidgetState createState() =>
      _SchedulingSpecialtyFilterWidgetState();
}

class _SchedulingSpecialtyFilterWidgetState
    extends State<SchedulingSpecialtyFilterWidget> {
  final SchedulingSpecialtyFilterStore store = Modular.get();
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
        store.getSpecialtiesParams(textController.text);
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
          builder: (_) => _buildSpecialtySheetWidget(_),
        );
      },
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: TripleBuilder<SchedulingSpecialtyFilterStore, DioError,
          SpecialtyModel>(
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
                      SchedulingLabels.schedulingSpecialtyFilterTitle,
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
                      store.onChangeSpecialty(SpecialtyModel());
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
                        SchedulingLabels.schedulingSpecialtyFilterClean,
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

  Widget _buildSpecialtySheetWidget(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeaderWidget(
                title: SchedulingLabels.schedulingSpecialtyFilterSearchTitle,
                controller: textController,
                searchPlaceholder:
                    SchedulingLabels.schedulingSpecialtyFilterSearchPlaceholder,
                onSearch: store.getSpecialtiesParams,
                showSearch: true,
              ),
              Flexible(child: _buildSpecialtyListWidget),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildSpecialtyListWidget {
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
        if (store.specialties.results!.isEmpty) {
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
                message: SchedulingLabels.schedulingSpecialtyFilterEmpty,
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!triple.isLoading) const SizedBox(height: 2.5),
            if (triple.isLoading)
              LinearProgressIndicator(
                color: Theme.of(context).primaryColor,
                minHeight: 2.5,
              ),
            Flexible(
              child: ListView.builder(
                itemCount: store.specialties.results!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return _buildSpecialtyItemWidget(
                    store.specialties.results![index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSpecialtyItemWidget(SpecialtyModel specialty) {
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
          store.onChangeSpecialty(specialty);
          Modular.to.pop();
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              specialty.name ??
                  SchedulingLabels.schedulingSpecialtyFilterNamePlaceholder,
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
