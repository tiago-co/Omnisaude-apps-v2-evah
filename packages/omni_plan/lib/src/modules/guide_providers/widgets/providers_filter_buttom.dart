import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:guide_providers_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/filters_store.dart';

class ProvidersFilterButtom extends StatefulWidget {
  final Function? initialSateOnTap;
  final Function modalItemOnTap;
  final String name;
  final String placeholder;
  final String searchText;
  final String errorText;
  final bool showClose;
  final Function onClose;
  const ProvidersFilterButtom({
    Key? key,
    required this.name,
    this.initialSateOnTap,
    required this.modalItemOnTap,
    required this.searchText,
    required this.errorText,
    required this.showClose,
    required this.onClose,
    required this.placeholder,
  }) : super(key: key);

  @override
  _ProvidersFilterButtomState createState() => _ProvidersFilterButtomState();
}

class _ProvidersFilterButtomState extends State<ProvidersFilterButtom> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  final FiltersStore filtersStore = Modular.get<FiltersStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.initialSateOnTap != null) {
          widget.initialSateOnTap!();
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => _buildChooseSheetWidget(context),
          );
        } else {
          widget.modalItemOnTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              Assets.filter,
              package: AssetsPackage.omniGeneral,
              width: 15,
              height: 15,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(width: 10),
            if (widget.showClose)
              GestureDetector(
                onTap: () {
                  widget.onClose();
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
                    GuideProvidersLabels.providersFilterClean,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom >= 60
                  ? MediaQuery.of(context).viewInsets.bottom - 60
                  : 0,
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                BottomSheetHeaderWidget(
                  title: widget.placeholder,
                  searchPlaceholder:
                      GuideProvidersLabels.providersFilterSearchPlaceholder,
                  controller: textEditingController,
                  onSearch: (String? input) {
                    //TODO: adicionar função de pesquisa
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: TripleBuilder<FiltersStore, DioError, List>(
              store: filtersStore,
              builder: (_, triple) {
                if (triple.event == TripleEvent.error) {
                  return SafeArea(
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () {
                        Modular.to.pop();
                      },
                    ),
                  );
                }

                if (triple.isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 25,
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LoadingWidget(),
                          const SizedBox(height: 15),
                          Text(
                            '${widget.searchText}...',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  );
                }

                if (filtersStore.state.isEmpty) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 25,
                      ),
                      child: EmptyWidget(
                        message: '${widget.errorText}!',
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!triple.isLoading) const SizedBox(height: 2.5),
                    if (triple.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          minHeight: 2.5,
                        ),
                      ),
                    Flexible(
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: filtersStore.state.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 15,
                          ),
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 50,
                          ),
                          itemBuilder: (_, index) {
                            return AbsorbPointer(
                              absorbing: triple.isLoading,
                              child: Opacity(
                                opacity: triple.isLoading ? 0.5 : 1.0,
                                child:
                                    _buildItemWidget(filtersStore.state[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemWidget(itemName) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.05),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          widget.modalItemOnTap(itemName);
          FocusScope.of(context).requestFocus(FocusNode());
          Modular.to.pop();
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              itemName,
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
