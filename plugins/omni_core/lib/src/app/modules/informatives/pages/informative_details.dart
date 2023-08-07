import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:informative_labels/labels.dart';
import 'package:omni_core/src/app/core/enums/informative_type_enum.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/modules/informatives/pages/widgets/informative_details_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/informatives/stores/informative_details_store.dart';
import 'package:omni_general/omni_general.dart';

class InformativeDetails extends StatefulWidget {
  final InformativeModel informative;
  const InformativeDetails({
    Key? key,
    required this.informative,
  }) : super(key: key);

  @override
  _InformativeDetailsState createState() => _InformativeDetailsState();
}

class _InformativeDetailsState extends State<InformativeDetails> {
  final InformativeDetailsStore store = Modular.get();
  final PdfViewService service = PdfViewService();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.getInformativeById(widget.informative.id!, service);
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.informative.title!,
      ).build(context) as AppBar,
      body: TripleBuilder<InformativeDetailsStore, DioError, InformativeModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const InformativeDetailsShimmerWidget();
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
                        onPressed: () => store.getInformativeById(
                          widget.informative.id!,
                          service,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Theme(
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
                store.getInformativeById(widget.informative.id!, service);
              },
              child: Builder(
                builder: (_) {
                  switch (triple.state.type) {
                    case InformativeType.html:
                      return _buildHtmlWidget(triple.state);
                    case InformativeType.pdf:
                      return _buildPdfWidget(triple.state);
                    case InformativeType.both:
                      return _buildBothWidget(triple.state);
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHtmlWidget(InformativeModel informative) {
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              controller: scrollController,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Html(
                    data: informative.content,
                    // customRenders: {
                    //   iframeMatcher(): iframeRender(),
                    // },
                    style: {
                      'html': Style(
                        margin: Margins.zero,
                      ),
                      'body': Style(
                        margin: Margins.zero,
                      ),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPdfWidget(
    InformativeModel informative, {
    bool isBottomSafe = true,
  }) {
    return Scaffold(
      body: TripleBuilder<PdfViewStore, Exception, bool>(
        store: store.pdfStore,
        builder: (_, triple) {
          if (!triple.state) return const LoadingWidget();

          return ClipRRect(child: service.pdfView(context));
        },
      ),
      bottomNavigationBar: TripleBuilder<PdfViewStore, Exception, bool>(
        store: store.pdfStore,
        builder: (_, triple) {
          return BottomButtonWidget(
            onPressed: () {
              store.pdfStore
                  .sharePDF(
                PDFDocumentType.url,
                _,
                url: store.state.url,
              )
                  .catchError((onError) {
                Helpers.showDialog(
                  context,
                  RequestErrorWidget(
                    message: InformativeLabels.informativeDetailsOnLoadingError,
                    buttonText: InformativeLabels.close,
                    onPressed: () => Modular.to.pop(),
                  ),
                  showClose: true,
                );
              });
            },
            isBottomSafe: isBottomSafe,
            buttonType: BottomButtonType.outline,
            isLoading: triple.isLoading,
            isDisabled: triple.isLoading || !triple.state,
            text: InformativeLabels.informativeDetailsShare,
          );
        },
      ),
    );
  }

  Widget _buildBothWidget(InformativeModel informative) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      informative.title ?? '',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                    ),
                    const SizedBox(height: 15),
                    Html(
                      data: informative.content,
                      style: {
                        'html': Style(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .fontFamily,
                        ),
                        'body': Style(
                            // margin: EdgeInsets.zero,
                            ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () async {
          store.pdfStore.loadPDF(
            service,
            PDFDocumentType.url,
            url: informative.url,
          );
          Helpers.showDialog(
            context,
            _buildPdfWidget(informative, isBottomSafe: false),
            showClose: true,
          );
        },
        buttonType: BottomButtonType.outline,
        text: InformativeLabels.informativeDetailsSeeFile,
      ),
    );
  }
}
