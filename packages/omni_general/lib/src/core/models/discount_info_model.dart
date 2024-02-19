class DiscountInfo {
  DiscountInfo(
    this.title,
    this.body, {
    this.parcels,
    this.value,
    this.subtitle,
    this.isExpanded = false,
  });
  String title;
  String? value;
  String? subtitle;
  String? parcels;
  List<String> body;
  bool isExpanded;
}
