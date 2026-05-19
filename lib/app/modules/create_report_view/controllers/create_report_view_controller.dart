import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../../app/data/models/report_model.dart';

class CreateReportViewController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();
  final authService = Get.find<AuthService>();
  
  final selectedImages = <File>[].obs;
  final isLoading = false.obs;

  // Controllers
  final descriptionController = TextEditingController();
  final selectedCategory = 'Infrastruktur Desa'.obs;
  final selectedSubCategory = ''.obs;

  final categories = [
    'Infrastruktur Desa',
    'Kebersihan Lingkungan',
    'Layanan Publik',
    'Keamanan & Ketertiban',
    'Darurat & Bencana',
    'Lainnya',
  ];

  final Map<String, List<String>> subCategories = {
    'Infrastruktur Desa': ['Jalan Rusak/Berlubang', 'Jembatan Rusak', 'Drainase Tersumbat', 'Fasilitas Umum Rusak'],
    'Kebersihan Lingkungan': ['Tumpukan Sampah', 'Saluran Air Kotor', 'Pencemaran Limbah'],
    'Layanan Publik': ['Pelayanan Surat Lambat', 'Kendala Administrasi', 'Kualitas Layanan'],
    'Keamanan & Ketertiban': ['Lampu Jalan Mati', 'Gangguan Keamanan', 'Keramaian Liar'],
    'Darurat & Bencana': ['Banjir', 'Tanah Longsor', 'Pohon Tumbang', 'Kebakaran'],
    'Lainnya': ['Masalah Lainnya'],
  };

  // Location Data
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = 'Sedang mencari lokasi...'.obs;

  @override
  void onInit() {
    super.onInit();
    selectedSubCategory.value = subCategories[selectedCategory.value]![0];
    _determinePosition();
  }

  void onCategoryChanged(String? val) {
    if (val != null) {
      selectedCategory.value = val;
      selectedSubCategory.value = subCategories[val]![0];
    }
  }

  Future<void> _determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      address.value = "Lokasi terdeteksi otomatis";
    } catch (e) {
      address.value = "Gagal mendapatkan lokasi";
    }
  }

  Future<void> pickImage(ImageSource source) async {
    if (selectedImages.length >= 3) {
      Get.snackbar('Peringatan', 'Maksimal 3 foto', 
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      isLoading.value = true;
      File? compressedFile = await compressImage(File(image.path));
      if (compressedFile != null) {
        selectedImages.add(compressedFile);
      }
      isLoading.value = false;
    }
  }

  Future<File?> compressImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final outPath = "${path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 70,
      minWidth: 1024,
      minHeight: 1024,
    );

    return result != null ? File(result.path) : null;
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  final apiService = Get.find<ApiService>();

  Future<void> submitReport() async {
    if (descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Silakan tulis rincian laporan',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      // Judul otomatis: "Kategori - SubKategori"
      String autoTitle = "${selectedCategory.value} - ${selectedSubCategory.value}";

      final response = await apiService.post('/reports/', {
        'title': autoTitle,
        'description': descriptionController.text,
        'category': selectedCategory.value,
        'coordinates': [latitude.value, longitude.value],
        'imageUrl': '', 
      });

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Berhasil', 'Laporan Anda telah terkirim',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Gagal', 'Terjadi kesalahan pada server',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengirim laporan: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}

