import 'package:omni_general_labels/labels.dart';

enum UploadInputType { galery, file, camera }

extension UploadInputTypeExtension on UploadInputType {
  String get label {
    switch (this) {
      case UploadInputType.galery:
        return GeneralLabels.uploadInputTypeGalery;
      case UploadInputType.file:
        return GeneralLabels.uploadInputTypeFile;
      case UploadInputType.camera:
        return GeneralLabels.uploadInputTypeCamera;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case UploadInputType.galery:
        return 'galery';
      case UploadInputType.file:
        return 'file';
      case UploadInputType.camera:
        return 'camera';
      default:
        return null;
    }
  }
}

UploadInputType? uploadInputTypeFromJson(String type) {
  switch (type) {
    case 'galery':
      return UploadInputType.galery;
    case 'file':
      return UploadInputType.file;
    case 'camera':
      return UploadInputType.camera;
    default:
      return null;
  }
}

enum SwitchType { horizontal, slide, vertical }

extension SwitchTypeExtension on SwitchType {
  String get label {
    switch (this) {
      case SwitchType.horizontal:
        return GeneralLabels.switchTypeHorizontal;
      case SwitchType.slide:
        return GeneralLabels.switchTypeSlide;
      case SwitchType.vertical:
        return GeneralLabels.switchTypeVertical;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case SwitchType.horizontal:
        return 'horizontal';
      case SwitchType.slide:
        return 'slide';
      case SwitchType.vertical:
        return 'vertical';
      default:
        return null;
    }
  }
}

SwitchType? switchTypeFromJson(String type) {
  switch (type) {
    case 'horizontal':
      return SwitchType.horizontal;
    case 'slide':
      return SwitchType.slide;
    case 'vertical':
      return SwitchType.vertical;
    default:
      return null;
  }
}

enum KeyboardType { date, email, number, text }

extension KeyboardTypeExtension on KeyboardType {
  String get label {
    switch (this) {
      case KeyboardType.date:
        return GeneralLabels.keyboardTypeDate;
      case KeyboardType.email:
        return GeneralLabels.keyboardTypeEmail;
      case KeyboardType.number:
        return GeneralLabels.keyboardTypeNumber;
      case KeyboardType.text:
        return GeneralLabels.keyboardTypeText;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case KeyboardType.date:
        return 'date';
      case KeyboardType.email:
        return 'email';
      case KeyboardType.number:
        return 'number';
      case KeyboardType.text:
        return 'text';
      default:
        return null;
    }
  }
}

KeyboardType? keyboardTypeFromJson(String type) {
  switch (type) {
    case 'data':
      return KeyboardType.date;
    case 'email':
      return KeyboardType.email;
    case 'numero':
      return KeyboardType.number;
    case 'texto':
      return KeyboardType.text;
    default:
      return null;
  }
}

enum InputType { date, email, text, decimal, integer }

extension InputTypeExtension on InputType {
  String get label {
    switch (this) {
      case InputType.date:
        return GeneralLabels.inputTypeDate;
      case InputType.email:
        return GeneralLabels.inputTypeEmail;
      case InputType.decimal:
        return GeneralLabels.inputTypeDecimal;
      case InputType.integer:
        return GeneralLabels.inputTypeInteger;
      case InputType.text:
        return GeneralLabels.inputTypeText;
      default:
        return toString();
    }
  }

  String get toJson {
    switch (this) {
      case InputType.date:
        return 'date';
      case InputType.email:
        return 'email';
      case InputType.integer:
        return 'integer';
      case InputType.decimal:
        return 'decimal';
      case InputType.text:
        return 'text';
      default:
        return toString();
    }
  }
}

InputType? inputTypeFromJson(String type) {
  switch (type) {
    case 'data':
      return InputType.date;
    case 'email':
      return InputType.email;
    case 'inteiro':
      return InputType.integer;
    case 'decimal':
      return InputType.decimal;
    case 'texto':
      return InputType.text;
    default:
      return null;
  }
}

enum Layout { avatarCard, button, card, imageCard }

extension LayoutExtension on Layout {
  String get label {
    switch (this) {
      case Layout.avatarCard:
        return GeneralLabels.layoutAvatarCard;
      case Layout.button:
        return GeneralLabels.layoutButton;
      case Layout.card:
        return GeneralLabels.layoutCard;
      case Layout.imageCard:
        return GeneralLabels.layoutImageCard;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case Layout.avatarCard:
        return 'avatarCard';
      case Layout.button:
        return 'button';
      case Layout.card:
        return 'card';
      case Layout.imageCard:
        return 'imageCard';
      default:
        return null;
    }
  }
}

Layout? layoutFromJson(String type) {
  switch (type) {
    case 'avatarCard':
      return Layout.avatarCard;
    case 'button':
      return Layout.button;
    case 'card':
      return Layout.card;
    case 'imageCard':
      return Layout.imageCard;
    default:
      return null;
  }
}

enum ContentFileType { custom, image, pdf, any }

extension ContentFileTypeExtension on ContentFileType {
  String get label {
    switch (this) {
      case ContentFileType.custom:
        return GeneralLabels.contentFileTypeCustom;
      case ContentFileType.image:
        return GeneralLabels.contentFileTypeImage;
      case ContentFileType.pdf:
        return GeneralLabels.contentFileTypePDF;
      case ContentFileType.any:
        return GeneralLabels.contentFileTypeAny;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case ContentFileType.custom:
        return 'custom';
      case ContentFileType.image:
        return 'image';
      case ContentFileType.pdf:
        return 'pdf';
      case ContentFileType.any:
        return 'any';
      default:
        return null;
    }
  }
}

ContentFileType? contentFileTypeFromJson(String type) {
  switch (type) {
    case 'custom':
      return ContentFileType.custom;
    case 'image':
      return ContentFileType.image;
    case 'pdf':
      return ContentFileType.pdf;
    case 'any':
      return ContentFileType.any;
    default:
      return null;
  }
}

enum RenderType { list, search, select, radio }

extension RenderTypeExtension on RenderType {
  String get label {
    switch (this) {
      case RenderType.list:
        return GeneralLabels.renderTypeList;
      case RenderType.search:
        return GeneralLabels.renderTypeSearch;
      case RenderType.select:
        return GeneralLabels.renderTypeSelect;
      case RenderType.radio:
        return GeneralLabels.renderTypeRadio;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case RenderType.list:
        return 'list';
      case RenderType.search:
        return 'search';
      case RenderType.select:
        return 'select';
      case RenderType.radio:
        return 'radio';
      default:
        return null;
    }
  }
}

RenderType? renderTypeFromJson(String type) {
  switch (type) {
    case 'list':
      return RenderType.list;
    case 'search':
      return RenderType.search;
    case 'select':
      return RenderType.select;
    case 'radio':
      return RenderType.radio;
    default:
      return null;
  }
}

enum DynamicFormType { input, upload, select }

extension DynamicFormTypeExtension on DynamicFormType {
  String get label {
    switch (this) {
      case DynamicFormType.input:
        return GeneralLabels.dynamicFormTypeInput;
      case DynamicFormType.upload:
        return GeneralLabels.dynamicFormTypeUpload;
      case DynamicFormType.select:
        return GeneralLabels.dynamicFormTypeSelect;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case DynamicFormType.input:
        return 'input';
      case DynamicFormType.upload:
        return 'upload';
      case DynamicFormType.select:
        return 'select';
      default:
        return null;
    }
  }
}

DynamicFormType? dynamicFormTypeFromJson(String type) {
  switch (type) {
    case 'input':
      return DynamicFormType.input;
    case 'upload':
      return DynamicFormType.upload;
    case 'select':
      return DynamicFormType.select;
    default:
      return null;
  }
}
