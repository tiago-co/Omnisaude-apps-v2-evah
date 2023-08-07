import 'package:dio/dio.dart';
import 'package:exams_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:internet_file/internet_file.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_core/src/app/modules/exams/stores/exam_store.dart';
import 'package:omni_core/src/app/modules/exams/stores/exams_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:pdfx/pdfx.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamDetailsPage extends StatefulWidget {
  final NewExamModel exams;

  const ExamDetailsPage({
    Key? key,
    required this.exams,
  }) : super(key: key);
  @override
  ExamDetailsPageState createState() => ExamDetailsPageState();
}

class ExamDetailsPageState extends State<ExamDetailsPage> {
  final ExamStore store = Modular.get();
  PdfController? pdfController;
  final ExamsStore examsStore = Modular.get();

  @override
  void initState() {
    store.getDetailExam(widget.exams.id);

    super.initState();
  }

  Future<void> _launchURL() async {
    final url = store.state.file;
    if (!await launch(
      url!,
      enableDomStorage: true,
    )) {
      throw '${ExamsLabels.examDetailsDeleteLauncheURLError}' ' $url';
    }
  }

  Future<PdfController> loadDocument() async {
    final pdfController = PdfController(
      document: PdfDocument.openData(InternetFile.get(store.state.file!)),
    );
    return pdfController;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NavBarWidget(
        title: widget.exams.name!,
        actions: [
          if (widget.exams.observation != '')
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
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
                  builder: (_) => _buildObservationWidget,
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.info_outlined,
                ),
              ),
            )
        ],
      ).build(context) as AppBar,
      body: TripleBuilder<ExamStore, DioError, NewExamModel>(
        store: store,
        builder: (_, triple) {
          if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      physics: const BouncingScrollPhysics(),
                      child: EmptyWidget(
                        message: ExamsLabels.examDetailsNoExam,
                        textButton: ExamsLabels.tryAgain,
                        onPressed: () => store.getDetailExam(widget.exams.id),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              TripleBuilder<ExamStore, DioError, NewExamModel>(
                store: store,
                builder: (_, triple) {
                  if (triple.isLoading) {
                    return const Expanded(
                      child: LoadingWidget(),
                    );
                  }

                  return Expanded(
                    child: FutureBuilder<PdfController>(
                      future: loadDocument(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.3),
                              ),
                            ),
                            child: PdfView(
                              controller: snapshot.data!,
                              scrollDirection: Axis.vertical,
                              builders: PdfViewBuilders<DefaultBuilderOptions>(
                                options: const DefaultBuilderOptions(),
                                documentLoaderBuilder: (_) =>
                                    const Center(child: LoadingWidget()),
                                pageLoaderBuilder: (_) =>
                                    const Center(child: LoadingWidget()),
                                errorBuilder: (_, __) => Center(
                                  child: RequestErrorWidget(
                                    message:
                                        ExamsLabels.examDetailsErrorOnLoadFile,
                                    buttonText: ExamsLabels.examDetailsBack,
                                    onPressed: () => Modular.to.pop(),
                                  ),
                                ),
                              ),
                              onDocumentError: (error) => RequestErrorWidget(
                                message: ExamsLabels.examDetailsErrorOnLoadFile,
                                buttonText: ExamsLabels.examDetailsBack,
                                onPressed: () => Modular.to.pop(),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  );
                },
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (store.state.file != null ||
                                store.state.name != null) {
                              Modular.to.pushNamed(
                                '/home/exams/new_exam',
                                arguments: store.state,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ExamsLabels.examDetailsEdit,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (store.state.file != null) _launchURL();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.download_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ExamsLabels.examDetailsDownload,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (store.state.id != null) {
                              Helpers.showDialog(
                                context,
                                _buildRemoveExamWidget,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.delete_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ExamsLabels.examDetailsDelete,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }

  Widget get _buildObservationWidget {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BottomSheetHeaderWidget(
              title: ExamsLabels.examDetailsBottomSheetTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 60,
              top: 10,
            ),
            child: Text(
              store.state.observation!,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildRemoveExamWidget {
    return TripleBuilder<ExamStore, DioError, NewExamModel>(
      store: store,
      builder: (_, triple) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            if (triple.isLoading) const LoadingWidget(),
            if (!triple.isLoading)
              Text(
                triple.event != TripleEvent.error
                    ? ExamsLabels.examDetailsWantDelete
                    : ExamsLabels.examDetailsErrorOnDelete,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DefaultButtonWidget(
                    onPressed: () => Navigator.pop(context),
                    text: 'Cancelar',
                    buttonType: DefaultButtonType.outline,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(primaryColor: Colors.red),
                    child: DefaultButtonWidget(
                      onPressed: () {
                        store.removeExam(store.state.id);
                      },
                      text: ExamsLabels.examDetailsDelete,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
