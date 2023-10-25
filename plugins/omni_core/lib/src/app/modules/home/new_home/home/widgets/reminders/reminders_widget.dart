import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/reminders/reminder_item.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/drug_control_historic_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';

class RemindersWidget extends StatefulWidget {
  RemindersWidget();

  @override
  State<RemindersWidget> createState() => _RemindersWidgetState();
}

class _RemindersWidgetState extends State<RemindersWidget> {
  final DrugControlHistoricStore store = Modular.get();
  @override
  void initState() {
    super.initState();
    store.params.limit = '10';
    store.getDrugControls(store.params);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return TripleBuilder<DrugControlHistoricStore, DioError, DrugControlResultsModel>(
      store: store,
      builder: (context, triple) {
        if (triple.isLoading) {
          return const LoadingWidget();
        }
        if (triple.state.results!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4 * fem),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      child: Text(
                        'Lembretes de Hoje',
                        style: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2999999306 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Modular.to.pushNamed(
                          '/newHome/reminders',
                          arguments: {
                            'moduleName': 'lembretes',
                            'program': ProgramModel(code: 'MEDICONAHORA'),
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        height: 24 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4 * fem),
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          height: double.infinity,
                          child: Center(
                            child: Center(
                              child: Text(
                                'Ver tudo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xff52576a),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: 150,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final reminder = store.state.results![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ReminderItem(
                        appointmentId: reminder.id!,
                        title: reminder.medicine!,
                        time: Formaters.stringToDateTime(reminder.startDate!),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
