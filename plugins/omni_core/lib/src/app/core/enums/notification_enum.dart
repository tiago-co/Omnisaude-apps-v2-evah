enum NotificationType { normal, reminder }
enum NotificationPriority { low, regular, hight }

extension NotificationTypeExtension on NotificationType {
  String? get toJson {
    switch (this) {
      case NotificationType.normal:
        return 'push';
      case NotificationType.reminder:
        return 'lembrete';
      default:
        return null;
    }
  }
}

NotificationType? notificationTypeFromJson(String? type) {
  switch (type) {
    case 'push':
      return NotificationType.normal;
    case 'lembrete':
      return NotificationType.reminder;
    default:
      return null;
  }
}

extension NotificationPriorityExtension on NotificationPriority {
  String? get toJson {
    switch (this) {
      case NotificationPriority.low:
        return 'baixa';
      case NotificationPriority.regular:
        return 'media';
      case NotificationPriority.hight:
        return 'alta';
      default:
        return null;
    }
  }
}

NotificationPriority? notificationPriorityFromJson(String? priority) {
  switch (priority) {
    case 'baixa':
      return NotificationPriority.low;
    case 'media':
      return NotificationPriority.regular;
    case 'alta':
      return NotificationPriority.hight;
    default:
      return null;
  }
}
