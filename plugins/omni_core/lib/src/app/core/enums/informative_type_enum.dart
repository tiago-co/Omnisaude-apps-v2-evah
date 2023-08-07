import 'package:informative_labels/labels.dart';

enum InformativeType { html, pdf, both }

extension InformativeTypeExtension on InformativeType {
  String get label {
    switch (this) {
      case InformativeType.html:
        return InformativeLabels.informativeTypeHTML;
      case InformativeType.pdf:
        return InformativeLabels.informativeTypePDF;
      case InformativeType.both:
        return InformativeLabels.informativeTypeBoth;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case InformativeType.html:
        return 'html';
      case InformativeType.pdf:
        return 'pdf';
      case InformativeType.both:
        return 'html_pdf';
      default:
        return null;
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
