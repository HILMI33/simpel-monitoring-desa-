import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class PetaController extends GetxController {
  final currentLocation = LatLng(-6.200000, 106.816666).obs; // Default Jakarta
  final mapController = MapController();
  final isLoading = true.obs;

  // List markers (nanti diisi dari Firestore)
  final reportMarkers = <Marker>[].obs;
  final pembangunanMarkers = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Layanan lokasi tidak aktif.');
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Error', 'Izin lokasi ditolak.');
          isLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Izin lokasi ditolak permanen. Buka pengaturan.');
        isLoading.value = false;
        return;
      }

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

  void loadMarkers() {
    // TODO: Fetch from Firestore
    // Contoh Marker Laporan
    // reportMarkers.add(Marker(...));
  }
}
