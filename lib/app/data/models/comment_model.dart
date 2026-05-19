class CommentModel {
  final String id;
  final String userId;
  final String userName;
  final String userPhotoUrl;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? 'Warga',
      userPhotoUrl: json['user_photo_url'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'user_photo_url': userPhotoUrl,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
