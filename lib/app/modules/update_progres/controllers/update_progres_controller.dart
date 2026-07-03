import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../app/data/models/pembangunan_model.dart';
import '../../../../app/data/services/api_service.dart';

class UpdateProgresController extends GetxController {
  final project = Rxn<PembangunanModel>();
  final isFollowing = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is PembangunanModel) {
      project.value = Get.arguments as PembangunanModel;
      _checkFollowing();
    }
  }

  void _checkFollowing() {
    final userId = GetStorage().read('user_id');
    if (userId != null && project.value != null) {
      isFollowing.value = project.value!.followers.contains(userId);
    }
  }

  Future<void> toggleFollowProject() async {
    if (project.value == null) return;
    
    isLoading.value = true;
    try {
      final res = await Get.find<ApiService>().post('/projects/${project.value!.id}/follow', {});
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        isFollowing.value = data['is_following'];
        
        // Update local model
        final currentFollowers = List<String>.from(project.value!.followers);
        final userId = GetStorage().read('user_id');
        if (userId != null) {
          if (isFollowing.value) {
            currentFollowers.add(userId);
          } else {
            currentFollowers.remove(userId);
          }
          project.value = PembangunanModel(
            id: project.value!.id,
            title: project.value!.title,
            description: project.value!.description,
            budget: project.value!.budget,
            progress: project.value!.progress,
            latitude: project.value!.latitude,
            longitude: project.value!.longitude,
            status: project.value!.status,
            imageUrl: project.value!.imageUrl,
            startDate: project.value!.startDate,
            endDate: project.value!.endDate,
            followers: currentFollowers,
          );
        }
        
        Get.snackbar("Sukses", data['message'],
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal mengikuti update",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
