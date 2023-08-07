import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home_labels/labels.dart';
import 'package:omni_general/src/widgets/error/request_error_widget.dart';

enum ModuleType {
  scheduling,
  presential,
  teleAttendance,
  bot,
  informative,
  extraData,
  procedure,
  mediktor,
  measurement,
  vaccines,
  drugControl,
  caregiver,
  guideProviders,
  featuresContacts,
  extractCoparticipation,
  extractUtilization,
  incomeTaxStatement,
  planCard,
  reimbursement,
  refundTabStatus,
  general,
  exams,
  diseases,
  healthUnits,
  duplicateTickets,
  directDebit,
  examsDiscount,
  pharmacyDiscount,
  urgencyAttendance,
  otherAdvantages,
}

extension ModuleTypeExtension on ModuleType {
  String name(ModuleType type) {
    switch (type) {
      case ModuleType.scheduling:
        return HomeLabels.moduleTypeScheduling;
      case ModuleType.mediktor:
        return HomeLabels.moduleTypeMediktor;
      // case ModuleType.measurement:
      //   return 'Histórico de Medições';
      // case ModuleType.drugControl:
      //   return 'Medicamentos';
      case ModuleType.bot:
        return HomeLabels.moduleTypeBot;
      case ModuleType.exams:
        return HomeLabels.moduleTypeExams;
      case ModuleType.diseases:
        return HomeLabels.moduleTypeDiseases;
      case ModuleType.informative:
        return HomeLabels.moduleTypeInformative;
      case ModuleType.caregiver:
        return HomeLabels.moduleTypeCaregiver;
      case ModuleType.drugControl:
        return HomeLabels.moduleTypeDrugControl;
      case ModuleType.procedure:
        return HomeLabels.moduleTypeProcedure;
      case ModuleType.extraData:
        return HomeLabels.moduleTypeExtraData;
      case ModuleType.measurement:
        return HomeLabels.moduleTypeMeasurement;
      case ModuleType.vaccines:
        return HomeLabels.moduleTypeVaccines;
      case ModuleType.presential:
        return HomeLabels.moduleTypePresential;
      case ModuleType.teleAttendance:
        return HomeLabels.moduleTypeTeleAttendance;
      case ModuleType.planCard:
        return HomeLabels.moduleTypePlanCard;
      case ModuleType.reimbursement:
        return HomeLabels.moduleTypeReimbursement;
      case ModuleType.extractCoparticipation:
        return HomeLabels.moduleTypeExtractCoparticipation;
      case ModuleType.guideProviders:
        return HomeLabels.moduleTypeGuideProviders;
      case ModuleType.refundTabStatus:
        return HomeLabels.moduleTypeRefundTabStatus;
      case ModuleType.extractUtilization:
        return HomeLabels.moduleTypeExtractUtilization;
      case ModuleType.incomeTaxStatement:
        return HomeLabels.moduleTypeIncomeTaxStatement;
      case ModuleType.featuresContacts:
        return HomeLabels.moduleTypeFeaturesContacts;
      case ModuleType.duplicateTickets:
        return HomeLabels.moduleTypeDuplicateTickets;
      case ModuleType.directDebit:
        return HomeLabels.moduleTypeDirectDebit;
      case ModuleType.examsDiscount:
        return HomeLabels.moduleTypeExamsDiscount;
      case ModuleType.pharmacyDiscount:
        return HomeLabels.moduleTypePharmacyDiscount;
      case ModuleType.otherAdvantages:
        return HomeLabels.moduleTypeOtherAdvantages;
      case ModuleType.urgencyAttendance:
        return HomeLabels.urgencyAttendance;
      default:
        return HomeLabels.moduleTypeNoName;
    }
  }

  String description(ModuleCategoryType category) {
    switch (category) {
      case ModuleCategoryType.diagnosis:
        switch (this) {
          case ModuleType.scheduling:
            return 'Histórico de Agendamentos';
          case ModuleType.mediktor:
            return 'Histórico de Diagnósticos';
          // case ModuleType.measurement:
          //   return 'Histórico de Medições';
          // case ModuleType.drugControl:
          //   return 'Histórico de Medicamentos';
          case ModuleType.bot:
            return 'Chatbot';
          case ModuleType.diseases:
            return 'Alergias e Patologias';
          case ModuleType.vaccines:
            return 'Vacinas';
          default:
            return 'Sem nome';
        }
      case ModuleCategoryType.treatment:
        switch (this) {
          case ModuleType.informative:
            return 'Dicas de Saúde';
          case ModuleType.caregiver:
            return 'Cuidadores';
          // case ModuleType.drugControl:
          //   return 'Controle Medicamentoso';
          case ModuleType.procedure:
            return 'Procedimentos';
          case ModuleType.extraData:
            return 'Formulários';
          case ModuleType.bot:
            return 'Chatbot';
          case ModuleType.vaccines:
            return 'Vacinas';
          default:
            return 'Sem nome';
        }
      case ModuleCategoryType.prevent:
        switch (this) {
          case ModuleType.mediktor:
            return 'Assistente Médico';
          case ModuleType.informative:
            return 'Dicas de Saúde';
          case ModuleType.measurement:
            return 'Nova Medição';
          case ModuleType.drugControl:
            return 'Controle Medicamentoso';
          case ModuleType.scheduling:
            return 'Novo Agendamento';
          case ModuleType.presential:
            return 'Atendimento Presencial';
          case ModuleType.teleAttendance:
            return 'Teleatendimento';
          case ModuleType.bot:
            return 'Chatbot';
          default:
            return 'Sem nome';
        }
      case ModuleCategoryType.benefits:
        switch (this) {
          case ModuleType.examsDiscount:
            return 'Desconto em Exames';
          case ModuleType.pharmacyDiscount:
            return 'Desconto em Farmácia';
          case ModuleType.otherAdvantages:
            return 'Outras Vantagens';
          default:
            return 'Sem nome';
        }
      case ModuleCategoryType.other:
        switch (this) {
          case ModuleType.bot:
            return 'Chatbot';
          default:
            return 'Sem nome';
        }
      case ModuleCategoryType.home:
        switch (this) {
          case ModuleType.bot:
            return 'Chatbot';
          case ModuleType.planCard:
            return 'Minha Assinatura';
          default:
            return 'Sem nome';
        }
      default:
        return 'Sem nome';
    }
  }

  String asset(ModuleType type) {
    switch (type) {
      case ModuleType.scheduling:
        return 'assets/modules/scheduling/scheduling_historic.svg';
      case ModuleType.mediktor:
        return 'assets/modules/mediktor/mediktor_historic.svg';
      // case ModuleType.measurement:
      //   return 'assets/modules/measurement/measurement_historic.svg';
      case ModuleType.drugControl:
        return 'assets/modules/drug_control/drug_control_historic.svg';
      case ModuleType.presential:
        return 'assets/modules/scheduling/presential/icon_atendimento_presencial_two.svg';
      case ModuleType.teleAttendance:
        return 'assets/modules/scheduling/teleattendence/icon_atendimento_online_two.svg';
      case ModuleType.bot:
        return 'assets/modules/bot/bot.svg';
      case ModuleType.exams:
        return 'assets/icons/exam.svg';
      case ModuleType.diseases:
        return 'assets/icons/icon_patologia.svg';
      case ModuleType.informative:
        return 'assets/modules/informative/informative.svg';
      case ModuleType.caregiver:
        return 'assets/modules/caregiver/caregiver.svg';
      case ModuleType.procedure:
        return 'assets/modules/procedure/procedure.svg';
      case ModuleType.extraData:
        return 'assets/modules/extra_data/extra_data.svg';
      case ModuleType.measurement:
        return 'assets/modules/measurement/measurement_historic.svg';
      case ModuleType.vaccines:
        return 'assets/modules/vaccine/vaccine.svg';
      case ModuleType.guideProviders:
        return 'assets/modules/guide_providers/guide_providers.svg';
      case ModuleType.planCard:
        return 'assets/modules/plan_card/plan_card.svg';
      case ModuleType.incomeTaxStatement:
        return 'assets/modules/income_tax_statement/irpf_base.svg';
      case ModuleType.featuresContacts:
        return 'assets/modules/features_contacts/features_contacts.svg';
      case ModuleType.extractCoparticipation:
        return 'assets/modules/extract_coparticipation/extract_coparticipation.svg';
      case ModuleType.extractUtilization:
        return 'assets/modules/extract_utilization/extract_utilization.svg';
      case ModuleType.reimbursement:
        return 'assets/modules/reimbursement/reembolso_two.svg';
      case ModuleType.refundTabStatus:
        return 'assets/modules/refund_tab_status/status_guia_two.svg';
      case ModuleType.duplicateTickets:
        return 'assets/modules/duplicate_ticket/segunda_via_boleto_two.svg';
      case ModuleType.directDebit:
        return 'assets/modules/direct_debit/debito_two.svg';
      case ModuleType.examsDiscount:
        return 'assets/modules/exams_discounts/exams_discounts_two.svg';
      case ModuleType.pharmacyDiscount:
        return 'assets/modules/pharma_discounts/pharma_discounts_two.svg';
      case ModuleType.otherAdvantages:
        return 'assets/modules/other_discounts/other_discounts_two.svg';
      case ModuleType.urgencyAttendance:
        return 'assets/modules/scheduling/scheduling_historic.svg';
      default:
        return 'assets/test/test.svg';
    }
  }

  String assetBase(ModuleType type) {
    switch (type) {
      case ModuleType.scheduling:
        return 'assets/modules/scheduling/scheduling_historic_base.svg';
      case ModuleType.mediktor:
        return 'assets/modules/mediktor/mediktor_historic_base.svg';
      case ModuleType.measurement:
        return 'assets/modules/measurement/measurement_historic_base.svg';
      case ModuleType.drugControl:
        return 'assets/modules/drug_control/drug_control_historic_base.svg';
      case ModuleType.presential:
        return 'assets/modules/scheduling/presential/icon_atendimento_presencial_one.svg';
      case ModuleType.teleAttendance:
        return 'assets/modules/scheduling/teleattendence/icon_atendimento_online_one.svg';
      case ModuleType.bot:
        return 'assets/modules/bot/bot_base.svg';
      case ModuleType.exams:
        return 'assets/icons/exam.svg';
      case ModuleType.diseases:
        return 'assets/icons/icon_patologia.svg';
      case ModuleType.informative:
        return 'assets/modules/informative/informative_base.svg';
      case ModuleType.caregiver:
        return 'assets/modules/caregiver/caregiver_base.svg';
      case ModuleType.procedure:
        return 'assets/modules/procedure/procedure_base.svg';
      case ModuleType.extraData:
        return 'assets/modules/extra_data/extra_data_base.svg';
      case ModuleType.vaccines:
        return 'assets/modules/vaccine/vaccine.svg';
      case ModuleType.guideProviders:
        return 'assets/modules/guide_providers/guide_providers_base.svg';
      case ModuleType.planCard:
        return 'assets/modules/plan_card/plan_card_base.svg';
      case ModuleType.incomeTaxStatement:
        return 'assets/modules/income_tax_statement/irpf.svg';
      case ModuleType.featuresContacts:
        return 'assets/modules/features_contacts/features_contacts_base.svg';
      case ModuleType.extractCoparticipation:
        return 'assets/modules/extract_coparticipation/extract_coparticipation_base.svg';
      case ModuleType.extractUtilization:
        return 'assets/modules/extract_utilization/extract_utilization_base.svg';
      case ModuleType.reimbursement:
        return 'assets/modules/reimbursement/reembolso_one.svg';
      case ModuleType.refundTabStatus:
        return 'assets/modules/refund_tab_status/status_guia_one.svg';
      case ModuleType.duplicateTickets:
        return 'assets/modules/duplicate_ticket/segunda_via_boleto_one.svg';
      case ModuleType.directDebit:
        return 'assets/modules/direct_debit/debito_one.svg';
      case ModuleType.examsDiscount:
        return 'assets/modules/exams_discounts/exams_discounts_one.svg';
      case ModuleType.pharmacyDiscount:
        return 'assets/modules/pharma_discounts/pharma_discounts_one.svg';
      case ModuleType.otherAdvantages:
        return 'assets/modules/other_discounts/other_discounts_one.svg';
      case ModuleType.urgencyAttendance:
        return 'assets/modules/scheduling/scheduling_historic_base.svg';
      default:
        return 'assets/test/test.svg';
    }
  }

  Function()? moduleTypeOnTap(ModuleType type, String moduleName) {
    switch (type) {
      case ModuleType.reimbursement:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/reimbursement',
              arguments: {
                'moduleName': moduleName,
              },
            );
      case ModuleType.extractCoparticipation:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/coparticipationExtract',
              arguments: {
                'moduleName': moduleName,
              },
            );
      case ModuleType.guideProviders:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/guideProviders',
              arguments: {
                'moduleName': moduleName,
              },
            );
      case ModuleType.refundTabStatus:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/refundTabStatus',
            );
      case ModuleType.duplicateTickets:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/duplicateTickets',
              arguments: {
                'moduleName': moduleName,
              },
            );
      case ModuleType.directDebit:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/directDebit',
              arguments: {
                'moduleName': moduleName,
              },
            );

      case ModuleType.incomeTaxStatement:
        return () => Modular.to.pushNamed(
              '/home/omniPlan/incomeTaxStatement',
              arguments: {
                'moduleName': moduleName,
              },
            );

      case ModuleType.planCard:
        return null;

      default:
        return () {
          Modular.to.push(
            PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 250),
              pageBuilder: (context, animation, secondaryAnimation) {
                animation = Tween(begin: 0.0, end: 1.0).animate(
                  animation,
                );
                return FadeTransition(
                  opacity: animation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).cardColor,
                                width: 0.05,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: -5,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Material(
                                color: Colors.transparent,
                                child: RequestErrorWidget(
                                  buttonText: 'Fechar',
                                  message: 'Módulo em manutenção!\n\n'
                                      'Estamos trabalhando para disponibilizar '
                                      'novas funcionalidades.',
                                  onPressed: () => Modular.to.pop(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        };
    }
  }

  String? get toJson {
    switch (this) {
      case ModuleType.scheduling:
        return 'agendamento';
      case ModuleType.bot:
        return 'bot';
      case ModuleType.informative:
        return 'informativo';
      case ModuleType.extraData:
        return 'dados_extras';
      case ModuleType.procedure:
        return 'procedimento';
      case ModuleType.mediktor:
        return 'mediktor';
      case ModuleType.measurement:
        return 'medicao';
      case ModuleType.drugControl:
        return 'medicamento';
      case ModuleType.caregiver:
        return 'cuidador_medicamento';
      case ModuleType.planCard:
        return 'cartao_plano';
      case ModuleType.guideProviders:
        return 'guia_prestadores_plano';
      case ModuleType.teleAttendance:
        return 'teleatendimento';
      case ModuleType.presential:
        return 'atendimento_presencial';
      case ModuleType.featuresContacts:
        return 'caracteristicas_contatos_plano';
      case ModuleType.extractCoparticipation:
        return 'extrato_coparticipacao_plano';
      case ModuleType.extractUtilization:
        return 'extrato_utilizacao_plano';
      case ModuleType.exams:
        return 'meus_exames';
      case ModuleType.diseases:
        return 'minhas_doencas_alergias';
      case ModuleType.incomeTaxStatement:
        return 'demo_ir_plano';
      case ModuleType.reimbursement:
        return 'reembolso';
      case ModuleType.refundTabStatus:
        return 'status_guia_plano';
      case ModuleType.general:
        return 'geral';
      case ModuleType.duplicateTickets:
        return 'segunda_via_boleto';
      case ModuleType.directDebit:
        return 'debito_automatico';
      case ModuleType.examsDiscount:
        return 'desconto_exames';
      case ModuleType.pharmacyDiscount:
        return 'desconto_farmacia';
      case ModuleType.otherAdvantages:
        return 'outras_vantagens';
      case ModuleType.urgencyAttendance:
        return 'atendimento_urgencia';
      default:
        return null;
    }
  }
}

ModuleType? moduleTypeFromJson(String? type) {
  switch (type) {
    case 'medicamento':
      return ModuleType.drugControl;
    case 'agendamento':
      return ModuleType.scheduling;
    case 'teleatendimento':
      return ModuleType.teleAttendance;
    case 'atendimento_presencial':
      return ModuleType.presential;
    case 'informativo':
      return ModuleType.informative;
    case 'dados_extras':
      return ModuleType.extraData;
    case 'bot':
      return ModuleType.bot;
    case 'mediktor':
      return ModuleType.mediktor;
    case 'medicao':
      return ModuleType.measurement;
    case 'procedimento':
      return ModuleType.procedure;
    case 'cuidador_medicamento':
      return ModuleType.caregiver;
    case 'cartao_plano':
      return ModuleType.planCard;
    case 'caracteristicas_contatos_plano':
      return ModuleType.featuresContacts;
    case 'extrato_utilizacao_plano':
      return ModuleType.extractUtilization;
    case 'guia_prestadores_plano':
      return ModuleType.guideProviders;
    case 'extrato_coparticipacao_plano':
      return ModuleType.extractCoparticipation;
    case 'demo_ir_plano':
      return ModuleType.incomeTaxStatement;
    case 'meus_exames':
      return ModuleType.exams;
    case 'minhas_doencas_alergias':
      return ModuleType.diseases;
    case 'reembolso':
      return ModuleType.reimbursement;
    case 'status_guia_plano':
      return ModuleType.refundTabStatus;
    case 'geral':
      return ModuleType.general;
    case 'segunda_via_boleto':
      return ModuleType.duplicateTickets;
    case 'debito_automatico':
      return ModuleType.directDebit;
    case 'desconto_exames':
      return ModuleType.examsDiscount;
    case 'desconto_farmacia':
      return ModuleType.pharmacyDiscount;
    case 'outras_vantagens':
      return ModuleType.otherAdvantages;
    case 'atendimento_urgencia':
      return ModuleType.urgencyAttendance;
    default:
      return null;
  }
}

enum ModuleCategoryType {
  treatment,
  other,
  prevent,
  benefits,
  diagnosis,
  home,
  drawer,
}

extension ModuleCategoryTypeExtension on ModuleCategoryType {
  String get name {
    switch (this) {
      case ModuleCategoryType.diagnosis:
        return HomeLabels.moduleCategoryDiagnosis;
      case ModuleCategoryType.other:
        return HomeLabels.moduleCategoryOther;
      case ModuleCategoryType.treatment:
        return HomeLabels.moduleCategoryTreatment;
      case ModuleCategoryType.prevent:
        return HomeLabels.moduleCategoryPrevent;
      case ModuleCategoryType.benefits:
        return HomeLabels.moduleCategoryBenefits;
      case ModuleCategoryType.home:
        return HomeLabels.moduleCategoryHome;
      case ModuleCategoryType.drawer:
        return HomeLabels.moduleCategoryDrawer;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case ModuleCategoryType.treatment:
        return 'tratamento';
      case ModuleCategoryType.other:
        return 'other';
      case ModuleCategoryType.prevent:
        return 'prevencao';
      case ModuleCategoryType.benefits:
        return 'beneficios';
      case ModuleCategoryType.diagnosis:
        return 'diagnostico';
      case ModuleCategoryType.home:
        return 'home';
      case ModuleCategoryType.drawer:
        return 'drawer';
      default:
        return toString();
    }
  }
}

ModuleCategoryType categoryTypeFromJson(String? category) {
  switch (category) {
    case 'tratamento':
      return ModuleCategoryType.treatment;
    case 'home':
      return ModuleCategoryType.home;
    case 'diagnostico':
      return ModuleCategoryType.diagnosis;
    case 'prevencao':
      return ModuleCategoryType.prevent;
    case 'beneficios':
      return ModuleCategoryType.benefits;
    case 'drawer':
      return ModuleCategoryType.drawer;
    default:
      return ModuleCategoryType.other;
  }
}
