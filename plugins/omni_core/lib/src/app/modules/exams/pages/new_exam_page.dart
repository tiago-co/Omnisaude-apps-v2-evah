import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:exams_labels/labels.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mime/mime.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/exams/stores/exam_store.dart';
import 'package:omni_core/src/app/modules/exams/stores/exams_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:path/path.dart' show basename;

class NewExamPage extends StatefulWidget {
  final NewExamModel? exams;

  const NewExamPage({
    Key? key,
    this.exams,
  }) : super(key: key);
  @override
  NewExamPageState createState() => NewExamPageState();
}

class NewExamPageState extends State<NewExamPage> {
  final ExamStore store = Modular.get();
  late final TextEditingController nametextcontroller;
  late final TextEditingController observacaocontroller;
  final ExamsStore examsStore = Modular.get();

  bool _loadingPath = false;

  @override
  void initState() {
    nametextcontroller = TextEditingController(
      text: widget.exams != null ? widget.exams!.name : '',
    );
    observacaocontroller = TextEditingController(
      text: widget.exams != null ? widget.exams!.observation : '',
    );
    if (widget.exams != null) log(widget.exams!.filename.toString());
    super.initState();
  }

  Future<void> getFileExam() async {
    final FilePickerService service = FilePickerService();
    setState(() {
      _loadingPath = true;
    });

    await service.getFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ).then(
      (file) {
        log(file.toString());
        file.isEmpty
            ? setState(() {
                _loadingPath = false;
              })
            : file.forEach(
                (file) {
                  final String ext = lookupMimeType(file.path) ?? '';
                  final fileName = basename(file.path);
                  final String base64 = UriData.fromBytes(
                    file.readAsBytesSync(),
                    mimeType: ext,
                  ).toString();
                  if (!mounted) return;
                  setState(() {
                    _loadingPath = false;
                  });
                  log(fileName);
                  store.state.file = base64;
                  store.state.filename = fileName;
                  store.update(
                    NewExamModel.fromJson(
                      store.state.toJson(),
                    ),
                  );
                },
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NavBarWidget(
        title: widget.exams == null
            ? ExamsLabels.newExamNewExam
            : ExamsLabels.newExamEditExam,
      ).build(context) as AppBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldWidget(
              maxLines: 1,
              maxLenght: 35,
              label: ExamsLabels.newExamNameLabel,
              placeholder: ExamsLabels.newExamNamePlaceholder,
              controller: nametextcontroller,
              textInputAction: TextInputAction.next,
              onSubmitted: (String name) {
                store.state.name = name;
                store.update(NewExamModel.fromJson(store.state.toJson()));
              },
              onChange: (String? name) {
                store.state.name = name;
                store.update(NewExamModel.fromJson(store.state.toJson()));
              },
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextFieldWidget(
              maxLenght: 250,
              maxLines: 6,
              label: ExamsLabels.newExamObservationLabel,
              placeholder: ExamsLabels.newExamObservationPlaceholder,
              controller: observacaocontroller,
              textInputAction: TextInputAction.next,
              onSubmitted: (String observation) {
                store.state.observation = observation;
                store.update(NewExamModel.fromJson(store.state.toJson()));
              },
              onChange: (String? observation) {
                store.state.observation = observation;
                store.update(NewExamModel.fromJson(store.state.toJson()));
              },
              prefixIcon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                getFileExam();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.025),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 140),
                child: Column(
                  children: [
                    Text(
                      ExamsLabels.newExamAddExam,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).cardColor,
                              ),
                    ),
                    const SizedBox(height: 40),
                    if (store.state.file == null)
                      SvgPicture.asset(
                        Assets.upload,
                        package: AssetsPackage.omniGeneral,
                        width: 80,
                        height: 80,
                      )
                    else
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 80,
                      ),
                    const SizedBox(height: 20),
                    Builder(
                      builder: (context) => _loadingPath
                          ? const LoadingWidget()
                          : Text(
                              store.state.filename != null
                                  ? store.state.filename!
                                  : widget.exams?.name != null
                                      ? widget.exams!.name!
                                      : '',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder<ExamStore, DioError, NewExamModel>(
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
                        message: widget.exams == null
                            ? ExamsLabels.newExamErrorOnAdd
                            : ExamsLabels.newExamErrorOnEdit,
                        textButton: ExamsLabels.tryAgain,
                        onPressed: () {
                          if (widget.exams == null) {
                            Modular.to.pop();
                          } else {
                            Modular.to.pop();
                            Modular.to.pop();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (widget.exams == null) {
            return BottomButtonWidget(
              isLoading: triple.isLoading,
              isDisabled: store.isDisabled,
              text: ExamsLabels.newExamAdd,
              buttonType: BottomButtonType.outline,
              onPressed: () {
                store.createExam(store.state);
              },
            );
          } else {
            return BottomButtonWidget(
              isLoading: triple.isLoading,
              isDisabled: store.isDisabled,
              text: ExamsLabels.newExamEdit,
              buttonType: BottomButtonType.outline,
              onPressed: () {
                store.editExam(store.state, widget.exams!.id);
              },
            );
          }
        },
      ),
    );
  }
}
