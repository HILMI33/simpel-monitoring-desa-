import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String role; // 'warga', 'admin'
  final String rt;
  final String rw;
  final DateTime? createdAt;
  final bool isFaceRegistered;
  final bool isEmailVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl = '',
    this.role = 'warga',
    this.rt = '',
    this.rw = '',
    this.createdAt,
    this.isFaceRegistered = false,
    this.isEmailVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      role: json['role'] ?? 'warga',
      rt: json['rt'] ?? '',
      rw: json['rw'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      isFaceRegistered: json['is_face_registered'] ?? false,
      isEmailVerified: json['is_email_verified'] ?? false,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      role: data['role'] ?? 'warga',
      rt: data['rt'] ?? '',
      rw: data['rw'] ?? '',
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
      'rt': rt,
      'rw': rw,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'role': role,
      'rt': rt,
      'rw': rw,
      'created_at': createdAt?.toIso8601String(),
      'is_face_registered': isFaceRegistered,
      'is_email_verified': isEmailVerified,
    };
  }
}
