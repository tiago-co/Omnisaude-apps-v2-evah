class OperatorConfigsModel {
  String? id;
  String? whitelabel;
  late final bool useCustomMedication;
  late final bool useCustomSchedulingReason;
  late final bool useProgramSegmentation;
  late final bool useMultiPrograms;
  late final bool useLeftProfram;
  late final bool useCaregiver;

  OperatorConfigsModel({
    this.id,
    this.whitelabel,
    this.useCustomMedication = false,
    this.useCustomSchedulingReason = false,
    this.useProgramSegmentation = false,
    this.useMultiPrograms = false,
    this.useLeftProfram = false,
    this.useCaregiver = false,
  });

  OperatorConfigsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    whitelabel = json['whitelabel'];
    useCustomMedication = json['use_medicamento_customizado'] ?? false;
    useCustomSchedulingReason =
        json['use_motivo_agendamento_customizado'] ?? false;
    useProgramSegmentation = json['use_segmentacao_psp'] ?? false;
    useMultiPrograms = json['use_empresa'] ?? false;
    useLeftProfram = json['use_abandono_psp'] ?? false;
    useCaregiver = json['use_cuidador_medicamento'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['whitelabel'] = whitelabel;
    data['use_medicamento_customizado'] = useCustomMedication;
    data['use_motivo_agendamento_customizado'] = useCustomSchedulingReason;
    data['use_segmentacao_psp'] = useProgramSegmentation;
    data['use_empresa'] = useMultiPrograms;
    data['use_abandono_psp'] = useLeftProfram;
    data['use_cuidador_medicamento'] = useCaregiver;
    return data;
  }
}
