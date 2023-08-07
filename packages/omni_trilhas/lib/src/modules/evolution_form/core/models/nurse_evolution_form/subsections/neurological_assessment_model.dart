import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/emotional_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/eye_opening_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/motor_deficit_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/orientation_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/pupils_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/nurse_evolution_form_enums/tone_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class NeurologicalAssessmentModel {
  String? id;
  PupilsType? pupils;
  OrientationType? orientation;
  EmotionalType? emotional;
  ToneType? tone;
  EyeOpeningType? eyeOpening;
  MotorDeficitType? motorDeficit;
  String? note;

  NeurologicalAssessmentModel({
    this.id,
    this.pupils,
    this.orientation,
    this.emotional,
    this.tone,
    this.eyeOpening,
    this.motorDeficit,
    this.note,
  });

  NeurologicalAssessmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pupils = pupilsTypeFromJson(json['pupilas']);
    orientation = orientationTypeFromJson(json['orientacao']);
    emotional = emotionalTypeFromJson(json['emocional']);
    tone = toneTypeFromJson(json['tonus']);
    eyeOpening = eyeOpeningTypeFromJson(json['abertura_ocular']);
    motorDeficit = motorDeficitTypeFromJson(json['deficit_motor']);
    note = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pupilas'] = pupils?.toJson;
    data['orientacao'] = orientation?.toJson;
    data['emocional'] = emotional?.toJson;
    data['tonus'] = tone?.toJson;
    data['abertura_ocular'] = eyeOpening?.toJson;
    data['deficit_motor'] = motorDeficit?.toJson;
    data['observacao'] = note;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['Pupilas'] = buildFieldMap(
      type: 'simple',
      value: pupils?.label,
    );
    data['Orientação'] = buildFieldMap(
      type: 'simple',
      value: orientation?.label,
    );
    data['Emocional'] = buildFieldMap(
      type: 'simple',
      value: emotional?.label,
    );
    data['Tonus'] = buildFieldMap(
      type: 'simple',
      value: tone?.label,
    );
    data['Abertura Ocular'] = buildFieldMap(
      type: 'simple',
      value: eyeOpening?.label,
    );
    data['Deficit Motor'] = buildFieldMap(
      type: 'simple',
      value: motorDeficit?.label,
    );
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: note,
    );

    return data;
  }
}
