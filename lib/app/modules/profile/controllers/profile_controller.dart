import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../../app/data/models/user_model.dart';
import '../../../../app/data/models/user_activity_log_model.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final authService = Get.find<AuthService>();
  final apiService = Get.find<ApiService>();

  final userName = 'Pengguna'.obs;
  final userPhone = '-'.obs;
  final userPhotoUrl = ''.obs;
  final userEmail = '-'.obs;
  final userRT = '-'.obs;
  final userRW = '-'.obs;

  final isIndonesian = true.obs; // Language toggle mock
  final isLoading = false.obs;
  final isLoadingLogs = false.obs;
  final myLogs = <UserActivityLogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchMyLogs();
  }

  void loadUserData() {
    final user = authService.currentUser.value;
    if (user != null) {
      userName.value = user.name;
      userEmail.value = user.email;
      userPhotoUrl.value = user.photoUrl;
      userPhone.value = user.phone.isNotEmpty ? user.phone : '-';
      userRT.value = user.rt.isNotEmpty ? user.rt : '-';
      userRW.value = user.rw.isNotEmpty ? user.rw : '-';
    }
  }

  void toggleLanguage() {
    isIndonesian.value = !isIndonesian.value;
    Get.snackbar(
      'Bahasa Diubah',
      isIndonesian.value ? 'Menggunakan Bahasa Indonesia' : 'Using English',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  Future<void> saveProfileDetails(
    String name,
    String phone,
    String rt,
    String rw,
  ) async {
    isLoading.value = true;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final res = await apiService.put('/auth/profile', {
        'name': name,
        'phone': phone,
        'rt': rt,
        'rw': rw,
      });

      if (res.statusCode == 200) {
        userName.value = name;
        userPhone.value = phone.isEmpty ? '-' : phone;
        userRT.value = rt.isEmpty ? '-' : rt;
        userRW.value = rw.isEmpty ? '-' : rw;
        // Update local model
        final user = authService.currentUser.value;
        if (user != null) {
          authService.currentUser.value = UserModel(
            id: user.id,
            name: name,
            email: user.email,
            photoUrl: user.photoUrl,
            role: user.role,
            rt: rt,
            rw: rw,
            isFaceRegistered: user.isFaceRegistered,
            isEmailVerified: user.isEmailVerified,
            phone: phone,
          );
        }
        Get.back(); // close dialog
        Get.back(); // back to profile
        Get.snackbar(
          'Berhasil',
          'Profil berhasil disimpan',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception('Gagal menyimpan profil');
      }
    } catch (e) {
      Get.back(); // close dialog
      Get.snackbar(
        'Error',
        'Gagal menyimpan profil: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      isLoading.value = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      try {
        final imageUrl = await apiService.uploadImage(pickedFile.path);
        if (imageUrl != null) {
          // Call backend to update profile
          final res = await apiService.put('/auth/profile', {
            'photo_url': imageUrl,
          });
          if (res.statusCode == 200) {
            userPhotoUrl.value = imageUrl;
            // Update auth service model implicitly or fetch again
            Get.back(); // close dialog
            Get.snackbar(
              'Berhasil',
              'Foto profil berhasil diperbarui',
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            throw Exception('Gagal menyimpan foto');
          }
        }
      } catch (e) {
        Get.back();
        Get.snackbar(
          'Error',
          'Gagal mengunggah foto: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void showInfoSheet(String title, String content) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B67F1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  'Tutup',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await authService.logout();
    box.write('isLoggedIn', false);
    box.erase();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> fetchMyLogs() async {
    isLoadingLogs.value = true;
    try {
      final response = await apiService.get('/auth/my-logs');
      if (response.statusCode == 200) {
        // Need to parse string response.body to JSON if it's a string, or use directly if it's already a map
        final Map<String, dynamic> data = response.body is String
            ? jsonDecode(response.body) as Map<String, dynamic>
            : response.body as Map<String, dynamic>;

        final List<dynamic> logsJson = data['logs'] ?? [];
        myLogs.value = logsJson
            .map((json) => UserActivityLogModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      debugPrint("Failed to fetch my logs: $e");
    } finally {
      isLoadingLogs.value = false;
    }
  }
}
