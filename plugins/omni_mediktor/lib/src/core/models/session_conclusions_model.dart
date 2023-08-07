import 'dart:convert';

import 'package:omni_mediktor/src/core/models/session_conclusion_object_model.dart';

class SessionConclusions {
  List<SessionConclusionObject>? summarySessionConclusionList;
  SessionConclusions({
    this.summarySessionConclusionList,
  });

  Map<String, dynamic> toMap() {
    return {
      'summarySessionConclusionList':
          summarySessionConclusionList?.map((x) => x.toMap()).toList(),
    };
  }

  factory SessionConclusions.fromMap(Map<String, dynamic> map) {
    return SessionConclusions(
      summarySessionConclusionList: map['summarySessionConclusionList'] != null
          ? List<SessionConclusionObject>.from(
              map['summarySessionConclusionList']
                  ?.map((x) => SessionConclusionObject.fromMap(x)),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionConclusions.fromJson(String source) =>
      SessionConclusions.fromMap(json.decode(source));
}
