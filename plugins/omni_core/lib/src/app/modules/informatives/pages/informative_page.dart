import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:informative_labels/labels.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_item_widget.dart';
import 'package:omni_core/src/app/modules/informatives/stores/informatives_store.dart';
import 'package:omni_general/omni_general.dart';

class InformativesPage extends StatefulWidget {
  final String pageName;
  const InformativesPage({Key? key, required this.pageName}) : super(key: key);

  @override
  _InformativesPageState createState() => _InformativesPageState();
}

class _InformativesPageState extends State<InformativesPage> {
  final InformativesStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.params.limit = '10';
    store.params.category = widget.pageName;

    store.getInformatives(store.params);

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getInformatives(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.pageName).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
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
                        label: 'Buscar',
                        controller: textController,
                        onChange: (String? input) {
                          store.getInformativesByName(input, store.params);
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
                  backgroundColor: Theme.of(context).colorScheme.background,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () async {
                    store.getInformatives(store.params);
                  },
                  child: _buildInformativesListWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildInformativesListWidget {
    return TripleBuilder<InformativesStore, DioError, InformativeResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const InformativeItemShimmerWidget();
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
                      onPressed: () => store.getInformatives(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            if (triple.state.results!.isEmpty && !triple.isLoading)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: InformativeLabels.informativeEmpty,
                          textButton: InformativeLabels.tryAgain,
                          onPressed: () => store.getInformatives(store.params),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (triple.state.results!.isNotEmpty)
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: triple.state.results!.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                      ),
                      itemBuilder: (context, index) {
                        return InformativeItemWidget(
                          informative: triple.state.results![index],
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
            loading,
          ],
        );
      },
    );
  }
}
