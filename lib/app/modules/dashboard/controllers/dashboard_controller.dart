import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../../app/data/models/report_model.dart';
import '../../../../app/data/models/pengumuman_model.dart';

class DashboardController extends GetxController {
  final box = GetStorage();
  final apiService = Get.find<ApiService>();
  final authService = Get.find<AuthService>();

  final userName = 'Pengguna'.obs;
  final userPhotoUrl = ''.obs;
  
  final totalLaporan = 0.obs;
  final laporanDiproses = 0.obs;
  final laporanSelesai = 0.obs;
  final recentReports = <ReportModel>[].obs;
  final recentAnnouncements = <PengumumanModel>[].obs;

  final currentBannerIndex = 0.obs;
  
  final banners = <PengumumanModel>[].obs;

  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await loadUserData();
    await fetchData();
    isLoading.value = false;
  }

  Future<void> loadUserData() async {
    final user = authService.currentUser.value;
    if (user != null) {
      userName.value = user.name;
      userPhotoUrl.value = user.photoUrl;
    }
  }

  Future<void> fetchData() async {
    try {
      // 1. Fetch Stats
      final statsRes = await apiService.get('/dashboard/user-stats');
      if (statsRes.statusCode == 200) {
        final data = jsonDecode(statsRes.body);
        totalLaporan.value = data['total_reports'] ?? 0;
        laporanDiproses.value = (data['on_progress_reports'] ?? 0) + (data['verified_reports'] ?? 0);
        laporanSelesai.value = data['resolved_reports'] ?? 0;
      }

      // 2. Fetch Recent Reports
      final reportRes = await apiService.get('/reports/');
      if (reportRes.statusCode == 200) {
        final List<dynamic> data = jsonDecode(reportRes.body);
        recentReports.value = data.map((json) => ReportModel.fromJson(json)).take(3).toList();
      }

      // 3. Fetch Announcements
      final announceRes = await apiService.get('/announcements/');
      if (announceRes.statusCode == 200) {
        final List<dynamic> data = jsonDecode(announceRes.body);
        final allAnnouncements = data.map((json) => PengumumanModel.fromJson(json)).toList();
        recentAnnouncements.value = allAnnouncements.take(2).toList();
        
        final carouselBanners = allAnnouncements.where((a) => a.isCarousel).toList();
        if (carouselBanners.isNotEmpty) {
          banners.value = carouselBanners;
        } else {
          // Fallback empty to not break
          banners.clear();
        }
      }
    } catch (e) {
      debugPrint('Error fetching dashboard data: $e');
    }
  }
}