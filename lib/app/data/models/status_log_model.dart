import 'package:cloud_firestore/cloud_firestore.dart';

class StatusLogModel {
  final String id;
  final String status;
  final String note;
  final DateTime timestamp;

  StatusLogModel({
    required this.id,
    required this.status,
    required this.note,
    required this.timestamp,
  });

  factory StatusLogModel.fromJson(Map<String, dynamic> json) {
    return StatusLogModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      note: json['note'] ?? '',
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
    );
  }

  factory StatusLogModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return StatusLogModel(
      id: doc.id,
      status: data['status'] ?? '',
      note: data['note'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'note': note,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
