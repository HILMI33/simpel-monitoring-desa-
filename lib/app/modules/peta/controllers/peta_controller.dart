import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/models/report_model.dart';
import '../../../../app/data/models/pembangunan_model.dart';

class PetaController extends GetxController {
  final apiService = Get.find<ApiService>();
  
  final currentLocation = const LatLng(-6.200000, 106.816666).obs; // Default Jakarta
  final mapController = MapController();
  final isLoading = true.obs;

  final markers = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    initPeta();
  }

  Future<void> initPeta() async {
    await getCurrentLocation();
    await fetchData();
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation.value = LatLng(position.latitude, position.longitude);
      mapController.move(currentLocation.value, 15.0);
    } catch (e) {
      Get.snackbar('Error', 'Gagal mendapatkan lokasi: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchData() async {
    try {
      final reportRes = await apiService.get('/reports/');
      final projectRes = await apiService.get('/projects/'); // Asumsi endpoint project ada

      List<ReportModel> reports = [];
      List<PembangunanModel> projects = [];

      if (reportRes.statusCode == 200) {
        final List<dynamic> data = jsonDecode(reportRes.body);
        reports = data.map((json) => ReportModel.fromJson(json)).toList();
      }

      if (projectRes.statusCode == 200) {
        final List<dynamic> data = jsonDecode(projectRes.body);
        projects = data.map((json) => PembangunanModel.fromJson(json)).toList();
      }

      updateMarkers(reports, projects);
    } catch (e) {
      debugPrint('Error fetching map data: $e');
    }
  }

  void updateMarkers(List<ReportModel> reports, List<PembangunanModel> projects) {
    final List<Marker> newMarkers = [];

    // User Location Marker
    newMarkers.add(
      Marker(
        point: currentLocation.value,
        width: 40,
        height: 40,
        child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
      ),
    );

    // Report Markers (Orange)
    for (var report in reports) {
      newMarkers.add(
        Marker(
          point: LatLng(report.latitude, report.longitude),
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () => _showDetailSnippet(report.title, report.status, 'Laporan Warga'),
            child: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
          ),
        ),
      );
    }

    // Project Markers (Green/Purple)
    for (var project in projects) {
      newMarkers.add(
        Marker(
          point: LatLng(project.latitude, project.longitude),
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () => _showDetailSnippet(project.title, project.status, 'Pembangunan Desa'),
            child: const Icon(Icons.construction_rounded, color: Color(0xFF5B67F1), size: 30),
          ),
        ),
      );
    }

    markers.assignAll(newMarkers);
  }

  void _showDetailSnippet(String title, String status, String type) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B67F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(color: Color(0xFF5B67F1), fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(status.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B67F1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Get.back(),
                child: const Text('Tutup', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
