import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/data/services/firestore_service.dart';
import '../../../../app/data/models/report_model.dart';

class DashboardController extends GetxController {
  final userName = ''.obs;
  final userPhotoUrl = ''.obs;
  
  final totalLaporan = 0.obs;
  final laporanDiproses = 0.obs;
  final laporanSelesai = 0.obs;

  final currentBannerIndex = 0.obs;
  
  // Real banners now can be fetched from Pengumuman, but for now we keep some static ones or mix
  final banners = [
    {
      'title': 'Waspada Demam Berdarah',
      'subtitle': 'Jaga kebersihan lingkungan dengan 3M Plus',
      'color': const Color(0xFFE53935), // Merah
      'icon': Icons.warning_rounded,
    },
    {
      'title': 'Bantuan Langsung Tunai',
      'subtitle': 'Pencairan tahap 2 dimulai minggu depan',
      'color': const Color(0xFF43A047), // Hijau
      'icon': Icons.payments_rounded,
    },
    {
      'title': 'Lapor Cepat',
      'subtitle': 'Gunakan fitur Laporan untuk keluhan warga',
      'color': const Color(0xFF5B67F1), // Biru
      'icon': Icons.flash_on_rounded,
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    listenToLaporan();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('user_name') ?? 'Pengguna';
    userPhotoUrl.value = prefs.getString('user_photo') ?? '';
  }

  void listenToLaporan() {
    try {
      final firestoreService = Get.find<FirestoreService>();
      firestoreService.streamReports().listen((List<ReportModel> reports) {
        totalLaporan.value = reports.length;
        laporanDiproses.value = reports.where((r) => r.status == 'diproses').length;
        laporanSelesai.value = reports.where((r) => r.status == 'selesai').length;
      });
    } catch (e) {
      debugPrint('Error listening to reports: $e');
    }
  }
}