import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/report_model.dart';
import '../models/pembangunan_model.dart';
import '../models/pengumuman_model.dart';
import '../models/status_log_model.dart';

class FirestoreService extends GetxService {
  FirebaseFirestore? get _db {
    try {
      return FirebaseFirestore.instance;
    } catch (e) {
      return null;
    }
  }

  // --- Users ---
  Future<void> saveUser(UserModel user) async {
    if (_db == null) return;
    try {
      await _db!.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      debugPrint('Firestore Error (saveUser): $e');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    if (_db == null) return null;
    try {
      DocumentSnapshot doc = await _db!.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
    } catch (e) {
      debugPrint('Firestore Error (getUser): $e');
    }
    return null;
  }

  // --- Reports ---
  Future<void> createReport(ReportModel report) async {
    if (_db == null) return;
    try {
      await _db!.collection('reports').doc(report.id).set(report.toMap());
    } catch (e) {
      debugPrint('Firestore Error (createReport): $e');
    }
  }

  Stream<List<ReportModel>> streamReports() {
    if (_db == null) {
      // Return Mock Data jika Firebase belum aktif
      return Stream.value([
        ReportModel(
          id: '1',
          userId: 'user1',
          userName: 'Budi Santoso',
          title: 'Lampu Jalan Mati',
          description: 'Lampu jalan di RT 03 sudah mati selama 3 hari, mohon diperbaiki.',
          latitude: -6.2,
          longitude: 106.8,
          status: 'pending',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        ReportModel(
          id: '2',
          userId: 'user2',
          userName: 'Siti Aminah',
          title: 'Sampah Menumpuk',
          description: 'Sampah di depan pasar meluap dan bau menyengat.',
          latitude: -6.21,
          longitude: 106.81,
          status: 'diproses',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        ReportModel(
          id: '3',
          userId: 'user3',
          userName: 'Agus Prayogo',
          title: 'Jalan Berlubang',
          description: 'Ada lubang cukup dalam di dekat jembatan utama.',
          latitude: -6.19,
          longitude: 106.82,
          status: 'selesai',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ]);
    }
    try {
      return _db!.collection('reports')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => ReportModel.fromFirestore(doc)).toList());
    } catch (e) {
      return Stream.value([]);
    }
  }

  // --- Pembangunan ---
  Stream<List<PembangunanModel>> streamPembangunan() {
    if (_db == null) {
      return Stream.value([
        PembangunanModel(
          id: 'p1',
          title: 'Pembangunan Drainase',
          description: 'Perbaikan saluran air sepanjang 200m',
          budget: 50000000,
          progress: 75,
          latitude: -6.2,
          longitude: 106.8,
          status: 'On Progress',
        ),
        PembangunanModel(
          id: 'p2',
          title: 'Rehabilitasi Balai Desa',
          description: 'Pengecatan dan perbaikan atap',
          budget: 25000000,
          progress: 100,
          latitude: -6.21,
          longitude: 106.81,
          status: 'Completed',
        ),
      ]);
    }
    try {
      return _db!.collection('pembangunan')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => PembangunanModel.fromFirestore(doc)).toList());
    } catch (e) {
      return Stream.value([]);
    }
  }

  // --- Pengumuman ---
  Stream<List<PengumumanModel>> streamPengumuman() {
    if (_db == null) {
      return Stream.value([
        PengumumanModel(
          id: 'n1',
          title: 'Kerja Bakti Desa',
          content: 'Diharapkan kehadiran seluruh warga RT 01-05 untuk kerja bakti hari Minggu.',
          authorName: 'Kepala Desa',
          createdAt: DateTime.now(),
        ),
        PengumumanModel(
          id: 'n2',
          title: 'Penyaluran BLT Tahap 3',
          content: 'Penyaluran BLT akan dilaksanakan hari Senin di Balai Desa pukul 09:00.',
          authorName: 'Sekretaris Desa',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ]);
    }
    try {
      return _db!.collection('pengumuman')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => PengumumanModel.fromFirestore(doc)).toList());
    } catch (e) {
      return Stream.value([]);
    }
  }
  // --- Status Logs ---
  Future<List<StatusLogModel>> getReportLogs(String reportId) async {
    if (_db == null) {
      // Return Mock Data jika Firebase belum aktif
      if (reportId == '2') { // Contoh untuk laporan 'Sampah Menumpuk'
        return [
          StatusLogModel(
            id: 'l1',
            status: 'pending',
            note: 'Laporan diterima oleh sistem.',
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
          ),
          StatusLogModel(
            id: 'l2',
            status: 'verified',
            note: 'Petugas kebersihan telah mengonfirmasi lokasi.',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
          ),
          StatusLogModel(
            id: 'l3',
            status: 'on_progress',
            note: 'Truk pengangkut sampah sedang menuju lokasi.',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ];
      }
      return [
        StatusLogModel(
          id: 'l0',
          status: 'pending',
          note: 'Laporan telah diterima dan sedang menunggu verifikasi.',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        ),
      ];
    }
    try {
      final snapshot = await _db!
          .collection('reports')
          .doc(reportId)
          .collection('logs')
          .orderBy('timestamp', descending: false)
          .get();
      return snapshot.docs.map((doc) => StatusLogModel.fromFirestore(doc)).toList();
    } catch (e) {
      debugPrint('Firestore Error (getReportLogs): $e');
      return [];
    }
  }
}
