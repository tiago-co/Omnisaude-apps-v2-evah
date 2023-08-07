import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/appointment_model.dart';
import 'package:omni_scheduling/src/core/models/dynamic_medical_records_model.dart';
import 'package:omni_scheduling/src/core/models/medical_records_model.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/dynamic_medical_records_field_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_field_shimmer_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_field_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/dynamic_medical_records_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/medical_records_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class MedicalRecordsPage extends StatefulWidget {
  final AppointmentModel appointment;

  const MedicalRecordsPage({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  final MedicalRecordsStore store = Modular.get();
  @override
  void initState() {
    store.getMedicalRecordsById(widget.appointment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: SchedulingLabels.medicalRecordsTitle,
      ).build(context) as AppBar,
      body: Theme(
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
            store.getMedicalRecordsById(widget.appointment);
          },
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constrains) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: SafeArea(
                        child: _buildBodyWidget(constrains.maxHeight),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyWidget(double maxHeight) {
    if (widget.appointment.pep != null) {
      return TripleBuilder<MedicalRecordsStore, DioError, MedicalRecordsModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const MedicalRecordsFieldShimmerWidget();
          }
          if (!triple.isLoading && triple.error != null) {
            return SizedBox(
              height: maxHeight,
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: RequestErrorWidget(
                    error: triple.error,
                    onPressed: () {
                      store.getMedicalRecordsById(widget.appointment);
                    },
                  ),
                ),
              ),
            );
          }
          return MedicalRecordsFieldWidget(medicalRecords: triple.state);
        },
      );
    } else if (widget.appointment.medicalRecords != null) {
      return TripleBuilder<DynamicMedicalRecordsStore, DioError,
          DynamicMedicalRecordsModel>(
        store: store.dynamicStore,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const MedicalRecordsFieldShimmerWidget();
          }
          if (!triple.isLoading && triple.error != null) {
            return SizedBox(
              height: maxHeight,
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: RequestErrorWidget(
                    error: triple.error,
                    onPressed: () {
                      store.getMedicalRecordsById(widget.appointment);
                    },
                  ),
                ),
              ),
            );
          }
          if (triple.state.fields.isEmpty && triple.error == null) {
            return const EmptyWidget(
              message: SchedulingLabels.medicalRecordsNoFilled,
            );
          }
          if (triple.state.fields.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: triple.state.fields.map((field) {
                return DynamicMedicalRecordsFieldWidget(field: field);
              }).toList(),
            );
          }
          return const SizedBox();
        },
      );
    }
    return SizedBox(
      height: maxHeight,
      child: const Center(
        child: EmptyWidget(
          message: SchedulingLabels.medicalRecordsNoFilled,
        ),
      ),
    );
  }
}
