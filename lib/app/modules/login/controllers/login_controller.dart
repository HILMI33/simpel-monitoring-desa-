import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  // STORAGE
  final box = GetStorage();

  // TEXT CONTROLLER
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // HIDE PASSWORD
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleObscure() {
    obscurePassword.value = !obscurePassword.value;
  }

  bool _isValidCredential(String emailOrPhone, String password) {
    // RegisterController menyimpan:
    // name, email, phone, rt, rw, (tidak menyimpan password di code saat ini)
    // Agar tetap bisa jalan, kita pakai fallback:
    // - anggap "password" harus cocok dengan nilai yang disimpan jika ada
    // - kalau belum ada, password apa pun tidak akan lolos.
    final savedEmail = box.read('email') as String?;
    final savedPhone = box.read('phone') as String?;
    final savedPassword = box.read('password') as String?;

    final inputMatchesAccount =
        (savedEmail != null && savedEmail == emailOrPhone) ||
        (savedPhone != null && savedPhone == emailOrPhone);

    if (!inputMatchesAccount) return false;
    if (savedPassword == null) return false;

    return savedPassword == password;
  }

  void login() {
    final emailOrPhone = emailController.text.trim();
    final password = passwordController.text;

    if (emailOrPhone.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email / No. HP dan Password wajib diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final ok = _isValidCredential(emailOrPhone, password);
    if (!ok) {
      Get.snackbar(
        'Login gagal',
        'Email/No. HP atau password salah',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.offAllNamed(Routes.MAIN_NAVIGATION);
  }

  void loginGoogle() {
    // Placeholder: belum ada integrasi OAuth.
    Get.snackbar(
      'Info',
      'Belum diimplementasikan login Google',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

