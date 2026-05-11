import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {

  // STORAGE
  final box = GetStorage();

  // ================= STEP =================
  var currentStep = 0.obs;

  // ================= TEXT CONTROLLER =================
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final rtController = TextEditingController();
  final rwController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ================= HIDE PASSWORD =================
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  // ================= NEXT STEP =================
  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  // ================= PREVIOUS STEP =================
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  // ================= REGISTER =================
  void register() {

    // VALIDASI
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {

      Get.snackbar(
        'Error',
        'Semua field wajib diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    // PASSWORD TIDAK SAMA
    if (passwordController.text !=
        confirmPasswordController.text) {

      Get.snackbar(
        'Error',
        'Konfirmasi password tidak cocok',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      return;
    }

    // SIMPAN DATA
    box.write('name', nameController.text);
    box.write('email', emailController.text);
    box.write('phone', phoneController.text);
    box.write('rt', rtController.text);
    box.write('rw', rwController.text);

    // SUCCESS
    Get.snackbar(
      'Berhasil',
      'Registrasi berhasil',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // PINDAH KE DASHBOARD
    Get.offAllNamed('/dashboard');
  }

  @override
  void onClose() {

    nameController.dispose();
    emailController.dispose();

    phoneController.dispose();

    rtController.dispose();
    rwController.dispose();

    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}