import 'package:omni_general_labels/labels.dart';

enum InformativeType { html, pdf, both }

extension InformativeTypeExtension on InformativeType {
  String get label {
    switch (this) {
      case InformativeType.html:
        return GeneralLabels.informativeTypeHTML;
      case InformativeType.pdf:
        return GeneralLabels.informativeTypePDF;
      case InformativeType.both:
        return GeneralLabels.informativeTypeBoth;
      default:
        return toString();
    }
  }

  String get toJson {
    switch (this) {
      case InformativeType.html:
        return 'html';
      case InformativeType.pdf:
        return 'pdf';
      case InformativeType.both:
        return 'html_pdf';
      default:
        return toString();
    }
  }
}

InformativeType? informativeTypeFromJson(String? type) {
  switch (type) {
    case 'html':
      return InformativeType.html;
    case 'pdf':
      return InformativeType.pdf;
    case 'html_pdf':
      return InformativeType.both;
    default:
      return null;
  }
}
