import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/report_model.dart';
import '../models/pembangunan_model.dart';
import '../models/pengumuman_model.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Users ---
  Future<void> saveUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  // --- Reports ---
  Future<void> createReport(ReportModel report) async {
    await _db.collection('reports').doc(report.id).set(report.toMap());
  }

  Stream<List<ReportModel>> streamReports() {
    return _db.collection('reports')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ReportModel.fromFirestore(doc)).toList());
  }

  // --- Pembangunan ---
  Stream<List<PembangunanModel>> streamPembangunan() {
    return _db.collection('pembangunan')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PembangunanModel.fromFirestore(doc)).toList());
  }

  // --- Pengumuman ---
  Stream<List<PengumumanModel>> streamPengumuman() {
    return _db.collection('pengumuman')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PengumumanModel.fromFirestore(doc)).toList());
  }
}
