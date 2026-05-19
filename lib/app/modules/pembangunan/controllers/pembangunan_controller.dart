import 'dart:convert';
import 'package:get/get.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/models/pembangunan_model.dart';

class PembangunanController extends GetxController {
  final apiService = Get.find<ApiService>();
  
  final selectedTab = 0.obs; // 0: Sedang Berjalan, 1: Selesai
  final projects = <PembangunanModel>[].obs;
  final filteredProjects = <PembangunanModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    isLoading.value = true;
    try {
      final response = await apiService.get('/projects/');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<PembangunanModel> loadedProjects = 
            data.map((json) => PembangunanModel.fromJson(json)).toList();
        projects.assignAll(loadedProjects);
        applyFilter();
      } else {
        Get.snackbar('Error', 'Gagal memuat proyek pembangunan');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal terhubung ke server');
      print('Pembangunan fetch error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
    applyFilter();
  }

  void applyFilter() {
    if (selectedTab.value == 0) {
      // Sedang Berjalan (Progress < 100)
      filteredProjects.assignAll(projects.where((p) => p.progress < 100).toList());
    } else {
      // Selesai (Progress == 100)
      filteredProjects.assignAll(projects.where((p) => p.progress == 100).toList());
    }
  }
}
