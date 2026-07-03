class UserActivityLogModel {
  final String id;
  final String action;
  final String target;
  final DateTime timestamp;

  UserActivityLogModel({
    required this.id,
    required this.action,
    required this.target,
    required this.timestamp,
  });

  factory UserActivityLogModel.fromJson(Map<String, dynamic> json) {
    return UserActivityLogModel(
      id: json['id'] ?? '',
      action: json['action'] ?? '',
      target: json['target'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
