import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/procedure_enum.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/modules/procedures/pages/widgets/refuse_procedure_item_widget.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedure_details_store.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/dynamic_form_field_shimmer_widget.dart';
import 'package:omni_core/src/app/shared/widgets/subtitle_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:procedures_labels/labels.dart';

class ProcedureDetailsWidget extends StatefulWidget {
  final ProcedureModel procedure;
  final VoidCallback callback;

  const ProcedureDetailsWidget({
    Key? key,
    required this.procedure,
    required this.callback,
  }) : super(key: key);

  @override
  _ProcedureDetailsWidgetState createState() => _ProcedureDetailsWidgetState();
}

class _ProcedureDetailsWidgetState extends State<ProcedureDetailsWidget> {
  final ProcedureDetailsStore store = Modular.get();
  @override
  void initState() {
    store.getProcedureById(widget.procedure.id!);
    super.initState();
  }

  void approveProcedure() {
    final Map<String, String> data = {
      'status': ProcedureStatus.approved.toJson!,
    };
    store.updateProcedure(widget.procedure.id!, data).then((value) {
      Modular.to.pop();
    }).catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          error: onError,
          onPressed: () => Modular.to.pop(),
          buttonText: ProceduresLabels.close,
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.procedure.name ??
                  ProceduresLabels.procedureDetailsProcedureNoName,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
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
                  store.getProcedureById(widget.procedure.id!);
                },
                child: _buildProcedureBodyWidget,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          TripleBuilder<ProcedureDetailsStore, DioError, ProcedureModel>(
        store: store,
        builder: (_, triple) {
          if (triple.state.status != ProcedureStatus.pending) {
            return const SizedBox();
          }
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                  child: BottomButtonWidget(
                    onPressed: () async {
                      Modular.to.pop();
                      await showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isScrollControlled: true,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        builder: (_) => RefuseProcedureItemWidget(
                          procedure: widget.procedure,
                        ),
                      ).whenComplete(() {
                        widget.callback();
                        Modular.to.pop();
                      });
                    },
                    text: ProceduresLabels.procedureDetailsReject,
                    isDisabled: triple.isLoading,
                    buttonType: BottomButtonType.outline,
                    isBottomSafe: false,
                  ),
                ),
              ),
              Expanded(
                child: BottomButtonWidget(
                  onPressed: approveProcedure,
                  isLoading: triple.isLoading,
                  text: ProceduresLabels.procedureDetailsAccept,
                  isBottomSafe: false,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget get _buildProcedureBodyWidget {
    return TripleBuilder<ProcedureDetailsStore, DioError, ProcedureModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return const DynamicFormFieldShimmerWidget();
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
                      onPressed: () {
                        store.getProcedureById(widget.procedure.id!);
                      },
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
            if (triple.state.id == null && !triple.isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: EmptyWidget(
                    message: ProceduresLabels.procedureDetailsEmpty,
                    textButton: ProceduresLabels.procedureDetailsTryAgain,
                    onPressed: () => store.getProcedureById(
                      widget.procedure.id!,
                    ),
                  ),
                ),
              ),
            if (triple.state.id != null)
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: _buildProcedureFormWidget(triple.state),
              ),
          ],
        );
      },
    );
  }

  Widget _buildProcedureFormWidget(ProcedureModel procedure) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SubtitleWidget(
            subtitle: ProceduresLabels.procedureDetailsHospitalDataSubTitle,
          ),
          const Divider(),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.hospitalName),
            label: ProceduresLabels.procedureDetailsHospitalNameLabel,
            placeholder:
                ProceduresLabels.procedureDetailsHospitalNamePlaceholder,
            readOnly: true,
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: procedure.zipCode,
                  ),
                  label: ProceduresLabels.procedureDetailsZipCodeLabel,
                  placeholder:
                      ProceduresLabels.procedureDetailsZipCodePlaceholder,
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 4,
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: procedure.uf,
                  ),
                  label: ProceduresLabels.procedureDetailsUfLabel,
                  placeholder: ProceduresLabels.procedureDetailsUfPlaceholder,
                  readOnly: true,
                ),
              ),
            ],
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.city),
            label: ProceduresLabels.procedureDetailsCityLabel,
            placeholder: ProceduresLabels.procedureDetailsCityPlaceholder,
            readOnly: true,
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.address),
            label: ProceduresLabels.procedureDetailsAddressLabel,
            placeholder: ProceduresLabels.procedureDetailsAddressPlaceholder,
            readOnly: true,
            maxLines: 5,
          ),
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: Formaters.dateToStringDate(
                      Formaters.stringToDateTime(procedure.date!),
                    ),
                  ),
                  label: ProceduresLabels.procedureDetailsProcedureDataLabel,
                  placeholder:
                      ProceduresLabels.procedureDetailsProcedureDataPlaceholder,
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: Formaters.dateToStringTime(
                      Formaters.stringToDateTime(procedure.date!),
                    ),
                  ),
                  label: ProceduresLabels.procedureDetailsProcedureHourLabel,
                  placeholder:
                      ProceduresLabels.procedureDetailsProcedureHourPlaceholder,
                  readOnly: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const SubtitleWidget(
            subtitle: ProceduresLabels.procedureDetailsProfessionalDataSubTitle,
          ),
          const Divider(),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.doctorName),
            label: ProceduresLabels.procedureDetailsDoctorNameLabel,
            placeholder: ProceduresLabels.procedureDetailsDoctorNamePlaceholder,
            readOnly: true,
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.doctorEmail),
            label: ProceduresLabels.procedureDetailsDoctorEmailLabel,
            placeholder:
                ProceduresLabels.procedureDetailsDoctorEmailPlaceholder,
            readOnly: true,
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.nurseName),
            label: ProceduresLabels.procedureDetailsNurseNameLabel,
            placeholder: ProceduresLabels.procedureDetailsNurseNamePlaceholder,
            readOnly: true,
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.nurseEmail),
            label: ProceduresLabels.procedureDetailsNurseEmailLabel,
            placeholder: ProceduresLabels.procedureDetailsNurseEmailPlaceholder,
            readOnly: true,
          ),
          const SizedBox(height: 15),
          const SubtitleWidget(
            subtitle: ProceduresLabels.procedureDetailsProcedureDataSubTitle,
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: Formaters.dateToStringDate(
                      Formaters.stringToDateTime(procedure.date!),
                    ),
                  ),
                  label: ProceduresLabels.procedureDetailsDateLabel,
                  placeholder: ProceduresLabels.procedureDetailsDatePlaceholder,
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: Formaters.dateToStringTime(
                      Formaters.stringToDateTime(procedure.date!),
                    ),
                  ),
                  label: ProceduresLabels.procedureDetailsHourLabel,
                  placeholder: ProceduresLabels.procedureDetailsHourPlaceholder,
                  readOnly: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: procedure.type?.label,
                  ),
                  label: ProceduresLabels.procedureDetailsTypeLabel,
                  placeholder: ProceduresLabels.procedureDetailsTypePlaceholder,
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextFieldWidget(
                  controller: TextEditingController(
                    text: procedure.status?.label,
                  ),
                  label: ProceduresLabels.procedureDetailsStatusLabel,
                  placeholder:
                      ProceduresLabels.procedureDetailsStatusPlaceholder,
                  readOnly: true,
                ),
              ),
            ],
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.reason),
            label: ProceduresLabels.procedureDetailsReasonLabel,
            placeholder: ProceduresLabels.procedureDetailsReasonPlaceholder,
            maxLines: 5,
            readOnly: true,
          ),
          TextFieldWidget(
            controller: TextEditingController(text: procedure.observation),
            label: ProceduresLabels.procedureDetailsObservationLabel,
            placeholder:
                ProceduresLabels.procedureDetailsObservationPlaceholder,
            maxLines: 5,
            readOnly: true,
          ),
          if (procedure.reasonCancel != null)
            TextFieldWidget(
              controller: TextEditingController(text: procedure.reasonCancel),
              label: ProceduresLabels.procedureDetailsCancelReasonLabel,
              placeholder:
                  ProceduresLabels.procedureDetailsCancelReasonPlaceholder,
              maxLines: 5,
              readOnly: true,
            ),
        ],
      ),
    );
  }
}
