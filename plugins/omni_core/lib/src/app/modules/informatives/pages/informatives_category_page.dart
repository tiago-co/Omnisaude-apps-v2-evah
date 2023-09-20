import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:informative_labels/labels.dart';
import 'package:omni_core/src/app/core/models/category_informative_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_category_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_category_item_widget.dart';
import 'package:omni_core/src/app/modules/informatives/stores/informatives_category_store.dart';
import 'package:omni_general/omni_general.dart';

class InformativesCategoryPage extends StatefulWidget {
  final String moduleName;
  const InformativesCategoryPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _InformativesCategoryPageState createState() =>
      _InformativesCategoryPageState();
}

class _InformativesCategoryPageState extends State<InformativesCategoryPage> {
  final InformativesCategoryStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.params.limit = '10';
    store.getCategories(store.params);

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getCategories(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TripleBuilder(
                  store: store,
                  builder: (_, triple) {
                    return Opacity(
                      opacity: triple.isLoading ? 0.5 : 1.0,
                      child: AbsorbPointer(
                        absorbing: triple.isLoading,
                        child: TextFieldWidget(
                          label: InformativeLabels.informativeCategoryLabel,
                          controller: textController,
                          placeholder:
                              InformativeLabels.informativeCategoryPlaceholder,
                          onChange: (String? input) {
                            if (input == null) return;
                            store.getCategoriesByName(input, store.params);
                          },
                          suffixIcon: SvgPicture.asset(
                            Assets.search,
                            package: AssetsPackage.omniGeneral,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    shadowColor: Colors.transparent,
                  ),
                  child: RefreshIndicator(
                    displacement: 0,
                    strokeWidth: 0.75,
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () async {
                      store.getCategories(store.params);
                    },
                    child: _buildInformativesListWidget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildInformativesListWidget {
    return TripleBuilder<InformativesCategoryStore, DioError,
        CategoryInformativeModelResultsModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const InformativeCategoryItemShimmerWidget();
        }
        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () => store.getCategories(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (triple.state.results!.isEmpty) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const BouncingScrollPhysics(),
                    child: EmptyWidget(
                      message: InformativeLabels.informativeCategoryEmpty,
                      textButton: InformativeLabels.informativeCategoryEmpty,
                      onPressed: () => store.getCategories(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: triple.state.results!.length,
          controller: scrollController,
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 50,
            left: 15,
            right: 15,
          ),
          itemBuilder: (context, index) {
            return InformativeCategoryItemWidget(
              category: triple.state.results![index],
            );
          },
        );
      },
    );
  }
}
