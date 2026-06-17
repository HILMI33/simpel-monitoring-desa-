import 'package:cloud_firestore/cloud_firestore.dart';
import 'status_log_model.dart';
import 'comment_model.dart';

class ReportModel {
  final String id;
  final String userId;
  final String userName;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String status; 
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? estimatedStartDate;
  final DateTime? estimatedEndDate;
  final DateTime? resolvedAt;
  final String adminNote;
  final String afterImageUrl;
  final int rating; 
  final List<StatusLogModel> logs;
  final List<String> likes;
  final List<CommentModel> comments;

  ReportModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.title,
    required this.description,
    this.category = 'Lainnya',
    this.imageUrl = '',
    required this.latitude,
    required this.longitude,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
    this.estimatedStartDate,
    this.estimatedEndDate,
    this.resolvedAt,
    this.adminNote = '',
    this.afterImageUrl = '',
    this.rating = 0,
    this.logs = const [],
    this.likes = const [],
    this.comments = const [],
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> coords = json['coordinates'] ?? [0.0, 0.0];
    List<dynamic> logsJson = json['logs'] ?? [];
    List<dynamic> likesJson = json['likes'] ?? [];
    List<dynamic> commentsJson = json['comments'] ?? [];
    return ReportModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? 'Warga',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'Lainnya',
      imageUrl: json['imageUrl'] ?? '',
      latitude: coords.isNotEmpty ? (coords[0] as num).toDouble() : 0.0,
      longitude: coords.length > 1 ? (coords[1] as num).toDouble() : 0.0,
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      adminNote: json['adminNote'] ?? '',
      afterImageUrl: json['afterImageUrl'] ?? '',
      rating: json['rating'] ?? 0,
      logs: logsJson.map((l) => StatusLogModel.fromJson(l)).toList(),
      likes: likesJson.map((l) => l.toString()).toList(),
      comments: commentsJson.map((c) => CommentModel.fromJson(c)).toList(),
    );
  }

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? 'Lainnya',
      imageUrl: data['imageUrl'] ?? '',
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
      status: data['status'] ?? 'pending',
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : null,
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : null,
      adminNote: data['adminNote'] ?? '',
      afterImageUrl: data['afterImageUrl'] ?? '',
      rating: data['rating'] ?? 0,
      logs: [], // Firestore uses subcollections usually
      likes: [],
      comments: [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'coordinates': [latitude, longitude],
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'adminNote': adminNote,
      'afterImageUrl': afterImageUrl,
      'rating': rating,
      'likes': likes,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }

  Map<String, dynamic> toMap() => toJson();
}
