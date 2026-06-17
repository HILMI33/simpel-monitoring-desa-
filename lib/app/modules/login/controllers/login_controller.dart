import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final authService = Get.find<AuthService>();

  // TEXT CONTROLLER
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // HIDE PASSWORD
  final obscurePassword = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Auto-login redirect disabled so the app always starts on the Login page
    /*
    if (authService.isLoggedIn.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.SECURITY_VERIFICATION);
      });
    }
    */
  }

  @override
  void onClose() {
    // Keep controllers active during fast route transitions to prevent GetX disposal race conditions
    super.onClose();
  }

  void toggleObscure() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan Password wajib diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      bool success = await authService.loginWithEmail(email, password);
      
      if (success) {
        box.write('isLoggedIn', true);
        Get.offAllNamed(Routes.SECURITY_VERIFICATION);
      }
    } catch (e) {
      Get.snackbar('Error', 'Login gagal: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginGoogle() async {
    try {
      isLoading.value = true;
      bool success = await authService.loginWithGoogle();
      
      if (success) {
        box.write('isLoggedIn', true);
        Get.offAllNamed(Routes.SECURITY_VERIFICATION);
      }
    } catch (e) {
      Get.snackbar('Error', 'Google Sign-In gagal: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
