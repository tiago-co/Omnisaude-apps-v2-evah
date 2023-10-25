import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/bottom_navigation_bar_widget.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/reminders/reminder_item.dart';
import 'package:omni_core/src/app/modules/new_reminders/hourly_timeline.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/drug_control_historic_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_medicine_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/widgets/reminder_form_bottom_sheet.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/drug_control_historic_item_widget.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/new_drug_control_date_filter_widget.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final DrugControlHistoricStore store = Modular.get();

  // final MedicineHistoricDateFilterStore store = Modular.get();
  final DatePickerController dateController = DatePickerController();

  @override
  void initState() {
    super.initState();
    store.params.limit = '10';
    store.getDrugControls(store.params);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => dateController.animateToDate(
        DateTime.now(),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    // height: 88 * fem,
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroup8831bbV (MYpEmhavFCVKGwZcx38831)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),

                          height: 40.5 * fem,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // leftWyM (I5103:26137;14:1611;14:1584)
                                margin: EdgeInsets.fromLTRB(0 * fem, 7.25 * fem, 0 * fem, 4.25 * fem),
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    width: 102 * fem,
                                    height: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Reminder',
                                        style: TextStyle(
                                          fontSize: 22 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2999999306 * ffem / fem,
                                          color: const Color(0xff1a1c22),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   // autogroupe4stuEo (MYpEsXkY7KZ6oqjTa8E4ST)
                              //   margin: EdgeInsets.fromLTRB(0 * fem, 5 * fem, 0 * fem, 0 * fem),
                              //   width: 81 * fem,
                              //   height: 32 * fem,
                              //   child: Container(
                              //     // masterbadgemasterSEj (I5103:26205;13:2572)
                              //     padding: EdgeInsets.fromLTRB(12 * fem, 6 * fem, 12 * fem, 6 * fem),
                              //     width: double.infinity,
                              //     height: double.infinity,
                              //     decoration: BoxDecoration(
                              //       border: Border.all(color: const Color(0xffededf1)),
                              //       borderRadius: BorderRadius.circular(16 * fem),
                              //     ),
                              //     child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: [
                              //         Container(
                              //           // autogroup5yjxjUj (MYpF1rqzVD5N98G5tY5yJX)
                              //           margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 8.27 * fem, 0 * fem),
                              //           padding: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 0 * fem),
                              //           height: double.infinity,
                              //           child: Text(
                              //             'Week',
                              //             style: TextStyle(
                              //               fontSize: 14 * ffem,
                              //               fontWeight: FontWeight.w400,
                              //               height: 1.4000000272 * ffem / fem,
                              //               color: const Color(0xff1a1c22),
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           width: 7.45 * fem,
                              //           height: 4.39 * fem,
                              //           child: const Icon(Icons.keyboard_arrow_down_rounded),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DayPickerTimelineWidget(
                    // DateTime(triple.state.year, triple.state.month),
                    DateTime(DateTime.now().year, DateTime.now().month),
                    locale: 'pt_BR',
                    // activeDates: activeDates,
                    controller: dateController,
                    // selectionColor: Theme.of(context).primaryColor,
                    selectionColor: const Color(0xff2D73B3),
                    initialSelectedDate: DateTime.now(),
                    deactivatedColor: Theme.of(context).cardColor.withOpacity(0.5),
                    monthTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 0,
                        ),
                    dayTextStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.grey),
                    dateTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                    daysCount: DateTime(2023, 10 + 1, 0)
                            .difference(
                              DateTime(2023, 10),
                            )
                            .inDays +
                        1,
                    onDateChange: (date) {
                      store.params.date = Formaters.dateToStringDate(
                        date,
                      );
                      store.getDrugControls(store.params);
                    },
                  ),
                  TripleBuilder<DrugControlHistoricStore, DioError, DrugControlResultsModel>(
                      store: store,
                      builder: (_, triple) {
                        Widget loading = const SizedBox();
                        if (triple.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (triple.event == TripleEvent.error) {
                          return Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: RequestErrorWidget(
                                      error: triple.error,
                                      onPressed: () => store.getDrugControls(store.params),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Expanded(
                          child: SfCalendar(
                            headerHeight: 0,
                            dataSource: store.getCalendarDataSource(),
                            cellBorderColor: Colors.white,
                            viewHeaderHeight: 0,
                            cellEndPadding: 0,
                            selectionDecoration: const BoxDecoration(),
                            timeSlotViewSettings: const TimeSlotViewSettings(
                              timeFormat: 'hh:mm a',
                              timeIntervalHeight: 90,
                              minimumAppointmentDuration: Duration(minutes: 30),
                              timeTextStyle: TextStyle(color: Colors.black),
                            ),
                            resourceViewSettings: const ResourceViewSettings(
                              visibleResourceCount: 2,
                            ),
                            showCurrentTimeIndicator: false,
                            appointmentBuilder: (context, appointment) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return OverflowBox(
                                    minHeight: 75,
                                    maxHeight: 75,
                                    child: ReminderItem(
                                      appointmentId: appointment.appointments.first.id,
                                      title: appointment.appointments.first.subject,
                                      time: appointment.appointments.first.startTime,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      })
                ],
              ),
              Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: Align(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ReminderFormBottomSheet(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 28,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffED8282),
                        borderRadius: BorderRadius.circular(60 * fem),
                      ),
                      child: Text(
                        'Adicionar lembrete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.7142857143 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[
      Appointment(
        startTime: DateTime(2023, 10, 22, 3, 45),
        endTime: DateTime(2023, 10, 22, 4, 15),
      ),
      Appointment(
        startTime: DateTime(2023, 10, 22, 0, 0),
        endTime: DateTime(2023, 10, 22, 1, 0),
      ),
    ];

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
