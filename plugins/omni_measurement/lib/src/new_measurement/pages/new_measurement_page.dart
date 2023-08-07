import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement/src/core/enums/category_step_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_step_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/measurement_helper_mode_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/measurement_how_you_feel_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/measurement_mode_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/measurement_type_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/new_measurement_success_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/receive_new_measurement_page.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/measurement_progress_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/bluetooth_scan_store.dart';
import 'package:omni_measurement/src/new_measurement/stores/bottom_button_store.dart';
import 'package:omni_measurement_labels/labels.dart';
import 'package:permission_handler/permission_handler.dart';

class NewMeasurementPage extends StatefulWidget {
  final String moduleName;
  final String specialtyId;
  const NewMeasurementPage({
    Key? key,
    required this.moduleName,
    required this.specialtyId,
  }) : super(key: key);
  @override
  NewMeasurementPageState createState() => NewMeasurementPageState();
}

class NewMeasurementPageState extends State<NewMeasurementPage> {
  final NewMeasurementStore store = Modular.get();
  final BluetoothScanStore _scanDeviceStore = Modular.get();
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(keepPage: false);
  final BottomButtonStore bottomButtonStore = Modular.get();
  String picture = '';

  void typePageNext(
    MeasurementModel form,
    MeasurementType measurementType,
  ) {
    store.counterButton++;
    if (store.categoryStep == 0) {
      store.onChangeMeasurementType(measurementType);
      store.updateForm(store.state);
      store.updateForm(MeasurementModel.fromJson(store.state.toJson()));
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void modePageNext(
    MeasurementModel form,
    MeasurementMode measurementMode,
  ) {
    store.counterButton++;
    store.onChangeMeasurementMode(measurementMode);
    bottomButtonStore.updateButton(true);
    store.updateForm(MeasurementModel.fromJson(store.state.toJson()));
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void helperPageNext(
    MeasurementModel form,
    MeasurementMode measurementMode,
  ) {
    store.onChangeMeasurementMode(measurementMode);
    bottomButtonStore.updateButton(true);
    store.updateForm(MeasurementModel.fromJson(store.state.toJson()));
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  Future<void> nextOrCreateMeasurement(MeasurementModel form) async {
    if (store.categoryStep == 2) {
      if (store.state.measurementMode == MeasurementMode.camera) {
        if (await Permission.camera.isGranted) {
          picture = await store.modePicture();
          if (picture != '-1') {
            store.counterButton++;
            store.counterPage++;
            pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
            final int virgula = picture.indexOf(',');
            final imageOCR = picture.substring(virgula + 1, picture.length);
            await store.getMeasurementOCR(imageOCR);
          }
        } else {
          await showDialog<Dialog>(
            context: context,
            builder: (BuildContext context) {
              return AlertPermissionDaniedWidget(
                color: Theme.of(context).primaryColor,
                permission: MeasurementLabels.newMeasurementCamera,
              );
            },
          );
        }
      } else {
        store.counterPage++;
        store.counterButton++;
        store.updateForm(store.state);
        pageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
    } else if (store.categoryStep == 3) {
      if (store.state.measurementMode == MeasurementMode.automatic) {
        await BluetoothServices.stopScanDevices();
        store.categoryStep = store.categoryStep - 1;
        await _scanDeviceStore
            .startScanningDevices(store.state.measurementType!)
            .catchError(
          (e) {
            Helpers.showDialog(
              context,
              const RequestErrorWidget(
                message: MeasurementLabels.newMeasurementError,
              ),
            );
          },
        );
      } else if (store.state.measurementMode == MeasurementMode.camera) {
        if (store.state.currentMeasure == '-1') {
          store.counterPage = store.counterPage - 2;
          store.counterButton--;
          store.categoryStep = store.counterPage;
          store.updateForm(store.state);
          pageController.previousPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        } else {
          store.counterButton++;
          store.state.imageMeasure = picture;
          store.updateForm(store.state);
          pageController.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        }
      } else if (store.state.measurementMode == MeasurementMode.manual) {
        if (_formKey.currentState!.validate()) {
          store.counterButton++;
          store.updateForm(store.state);
          FocusScope.of(context).unfocus();
          pageController.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        }
      }
    } else if (store.categoryStep == 4) {
      store.createMeasurement(form).then((value) {
        store.counterButton++;
        pageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }).catchError(
        (onError) {
          Helpers.showDialog(
            context,
            RequestErrorWidget(
              error: onError as DioError,
              onPressed: () => Modular.to.pop(),
              buttonText: MeasurementLabels.close,
            ),
            showClose: true,
          );
        },
      );
    } else if (store.categoryStep == 5) {
      store.counterPage = 0;
      store.categoryStep = 0;
      store.counterButton = 0;
      bottomButtonStore.updateButton(false);
      pageController.jumpToPage(0);
      store.state.date = null;
      store.state.currentMeasure = null;
      store.state.howAreYouFeeling = null;
      store.state.meal = null;
      store.state.measurementMode = null;
      store.state.measurementType = null;
      store.state.observations = null;
      store.updateForm(MeasurementModel.fromJson(store.state.toJson()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: NavBarWidget(
        title: widget.moduleName,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            children: [
              TripleBuilder<NewMeasurementStore, Exception, MeasurementModel>(
                store: store,
                builder: (_, triple) {
                  if (store.counterPage != 2 && store.counterPage != 5) {
                    return MeasurementProgressWidget(
                      step: store.categoryStep + 1,
                      quantitySteps: 4,
                      type: measurementStepTypeLabel(store.categoryStep)!,
                      nextTitle: store.categoryStep != 1
                          ? categoryStepEnumFromJson(store.categoryStep).label
                          : store.state.measurementType!.infoTypeMeasuarement,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (int value) {
                    if (value != 3 && value != 0) {
                      store.counterPage++;
                      store.categoryStep = store.counterPage;
                      store.updateForm(store.state);
                    }
                  },
                  children: [
                    MeasurementTypePage(
                      specialtyId: widget.specialtyId,
                      nextOrCreateMeasurement: typePageNext,
                    ),
                    MeasurementModePage(
                      pageController: pageController,
                      nextOrCreateMeasurement: modePageNext,
                    ),
                    MeasurementHelperModePage(
                      pageController: pageController,
                      nextOrCreateMeasurement: helperPageNext,
                    ),
                    ReceiveNewMeasurementPage(
                      pageController: pageController,
                      formKey: _formKey,
                      scaffoldKey: _scaffoldKey,
                    ),
                    MeasurementHowYouFeelPage(
                      pageController: pageController,
                    ),
                    NewMeasurementSuccessPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ScopedBuilder<BottomButtonStore, Exception, bool>(
        store: bottomButtonStore,
        onState: (_, scoped) {
          if (scoped) {
            //anteriormente estava assim
            // return _buildBottomButtomWidget;
            return store.state.measurementMode == MeasurementMode.automatic
                ? StreamBuilder<BluetoothAdapterState>(
                    stream: FlutterBluePlus.adapterState,
                    initialData: BluetoothAdapterState.unknown,
                    builder: (c, snapshot) {
                      final state = snapshot.data;
                      if (store.categoryStep == 2 &&
                          state == BluetoothAdapterState.off &&
                          store.counterPage == 3) {
                        return SizedBox.fromSize();
                      } else {
                        return _buildBottomButtomWidget;
                      }
                    },
                  )
                : _buildBottomButtomWidget;
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget get _buildBottomButtomWidget {
    return TripleBuilder<NewMeasurementStore, Exception, MeasurementModel>(
      store: store,
      builder: (_, triple) {
        return BottomButtonWidget(
          onPressed: () {
            if (store.categoryStep == 2 && store.counterPage == 3) {
              store.categoryStep = store.counterPage;
            }
            nextOrCreateMeasurement(store.state);
          },
          isLoading: triple.isLoading,
          isDisabled: store.isButtonDisabled(
            store.counterButton,
            triple.state,
          ),
          text: store.counterButton == 3 &&
                  store.state.measurementMode == MeasurementMode.automatic
              ? MeasurementLabels.newMeasurementSearchDevices
              : store.counterButton == 3 &&
                      store.state.measurementMode == MeasurementMode.camera &&
                      store.state.currentMeasure == '-1' &&
                      store.state.currentMeasure != 'null'
                  ? MeasurementLabels.newMeasurementTryAgain
                  : store.counterButton == 4
                      ? MeasurementLabels.newMeasurementSend
                      : store.counterButton == 5
                          ? MeasurementLabels.newMeasurementNewMeasurement
                          : MeasurementLabels.newMeasurementContinue,
        );
      },
    );
  }
}
