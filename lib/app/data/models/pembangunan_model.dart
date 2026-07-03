import 'package:cloud_firestore/cloud_firestore.dart';

class PembangunanModel {
  final String id;
  final String title;
  final String description;
  final double budget;
  final int progress; // 0 - 100
  final double latitude;
  final double longitude;
  final String status;
  final String imageUrl;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> followers;

  PembangunanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.progress,
    required this.latitude,
    required this.longitude,
    this.status = 'Planning',
    this.imageUrl = '',
    this.startDate,
    this.endDate,
    this.followers = const [],
  });

  factory PembangunanModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> coords = json['coordinates'] ?? [0.0, 0.0];
    return PembangunanModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      latitude: coords.isNotEmpty ? (coords[0] as num).toDouble() : 0.0,
      longitude: coords.length > 1 ? (coords[1] as num).toDouble() : 0.0,
      status: json['status'] ?? 'Planning',
      imageUrl: json['imageUrl'] ?? '',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      followers: List<String>.from(json['followers'] ?? []),
    );
  }

  factory PembangunanModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PembangunanModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      budget: data['budget']?.toDouble() ?? 0.0,
      progress: data['progress']?.toInt() ?? 0,
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
      status: data['status'] ?? 'Planning',
      imageUrl: data['imageUrl'] ?? '',
      startDate: data['startDate'] != null ? (data['startDate'] as Timestamp).toDate() : null,
      endDate: data['endDate'] != null ? (data['endDate'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'budget': budget,
      'progress': progress,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'imageUrl': imageUrl,
      'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
    };
  }
}
