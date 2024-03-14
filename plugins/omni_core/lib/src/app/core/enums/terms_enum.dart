import 'package:terms_labels/labels.dart';

enum TermsType {
  terms,
  programTerm,
  policies,
}

extension EnvTypeExtension on TermsType {
  String get label {
    switch (this) {
      case TermsType.terms:
        return TermsLabels.envTypeTerms;
      case TermsType.programTerm:
        return TermsLabels.envTypeProgramTerm;
      case TermsType.policies:
        return TermsLabels.envTypePolicies;
      default:
        return toString();
    }
  }

  String get toJson {
    switch (this) {
      case TermsType.terms:
        return 'termos';
      case TermsType.programTerm:
        return 'termo_programa';
      case TermsType.policies:
        return 'politicas';
      default:
        return toString();
    }
  }

  String get dotEnvLabel {
    switch (this) {
      case TermsType.terms:
        return 'TERMS_OF_USE_URL';
      case TermsType.programTerm:
        return '';
      case TermsType.policies:
        return 'PRIVACY_POLICIE_URL';
    }
  }
}
