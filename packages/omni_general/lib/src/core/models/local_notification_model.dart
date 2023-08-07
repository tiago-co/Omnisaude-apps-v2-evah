class ReceivedNotificationModel {
  final int id;
  final String title;
  final String body;
  final Map<String, dynamic> payload;

  ReceivedNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
