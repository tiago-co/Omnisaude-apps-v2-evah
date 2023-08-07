import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:informative_labels/labels.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_item_widget.dart';
import 'package:omni_core/src/app/modules/informatives/stores/mediktor_informative_store.dart';
import 'package:omni_general/omni_general.dart';

class MediktorInformativePage extends StatefulWidget {
  final String specialtyId;
  const MediktorInformativePage({
    Key? key,
    required this.specialtyId,
  }) : super(key: key);

  @override
  _MediktorInformativePageState createState() =>
      _MediktorInformativePageState();
}

class _MediktorInformativePageState extends State<MediktorInformativePage> {
  final MediktorInformativesStore store = Modular.get();
  @override
  void initState() {
    store.getMediktorInformatives(widget.specialtyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: InformativeLabels.mediktorInformativeTitle,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: <Widget>[
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
                    store.getMediktorInformatives(widget.specialtyId);
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
    return TripleBuilder<MediktorInformativesStore, DioError,
        MediktorInformativeResultsModel>(
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
                      onPressed: () =>
                          store.getMediktorInformatives(widget.specialtyId),
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
                          message: InformativeLabels.mediktorInformativeEmpty,
                          textButton: InformativeLabels.tryAgain,
                          onPressed: () =>
                              store.getMediktorInformatives(widget.specialtyId),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (triple.state.results!.isNotEmpty)
              ListView.separated(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                separatorBuilder: (_, index) => const SizedBox(height: 15),
                itemCount: triple.state.results!.length,
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 50,
                  left: 15,
                  right: 15,
                ),
                itemBuilder: (context, index) {
                  return InformativeItemWidget(
                    informative: triple.state.results![index],
                  );
                },
              ),
            loading,
          ],
        );
      },
    );
  }
}
