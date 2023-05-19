class Inbox {
  String id;
  String profileImageUrl;
  String comment;
  String foodPictureUrl;
  String timestamp;

  Inbox({
    required this.id,
    required this.profileImageUrl,
    required this.comment,
    required this.foodPictureUrl,
    required this.timestamp,
  });

  factory Inbox.fromJson(Map<String, dynamic> json) {
    return Inbox(
      id: json['id'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      comment: json['comment'] ?? '',
      foodPictureUrl: json['foodPictureUrl'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}
