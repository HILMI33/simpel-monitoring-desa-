import 'package:cloud_firestore/cloud_firestore.dart';

class PengumumanModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String authorName;
  final DateTime? createdAt;

  PengumumanModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl = '',
    this.authorName = 'Admin Desa',
    this.createdAt,
  });

  factory PengumumanModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PengumumanModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      authorName: data['authorName'] ?? 'Admin Desa',
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'authorName': authorName,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }
}
