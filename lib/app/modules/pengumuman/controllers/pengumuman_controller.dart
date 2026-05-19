import 'dart:convert';
import 'package:get/get.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/models/pengumuman_model.dart';

class PengumumanController extends GetxController {
  final apiService = Get.find<ApiService>();
  
  final selectedCategory = "Semua".obs;
  final categories = ["Semua", "Informasi", "Agenda", "Bantuan"];

  final allAnnouncements = <PengumumanModel>[].obs;
  final filteredAnnouncements = <PengumumanModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();
  }

  Future<void> fetchAnnouncements() async {
    isLoading.value = true;
    try {
      final response = await apiService.get('/announcements/');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<PengumumanModel> loadedAnnouncements = 
            data.map((json) => PengumumanModel.fromJson(json)).toList();
        allAnnouncements.assignAll(loadedAnnouncements);
        updateFilteredList();
      } else {
        Get.snackbar('Error', 'Gagal memuat pengumuman desa');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal terhubung ke server');
      print('Pengumuman fetch error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    updateFilteredList();
  }

  void updateFilteredList() {
    if (selectedCategory.value == "Semua") {
      filteredAnnouncements.assignAll(allAnnouncements);
    } else {
      // In real app, you might want a category field in PengumumanModel
      // For now we just filter by matching title/content keywords if category field is missing
      // or we can add category field to the model.
      filteredAnnouncements.assignAll(
        allAnnouncements.where((a) => a.title.contains(selectedCategory.value) || a.content.contains(selectedCategory.value)).toList()
      );
    }
  }
}
