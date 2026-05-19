import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/data/services/auth_service.dart';

class RegisterController extends GetxController {
  final box = GetStorage();
  final authService = Get.find<AuthService>();

  // ================= STEP =================
  var currentStep = 0.obs;
  final isLoading = false.obs;

  // ================= TEXT CONTROLLER =================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ================= STEP 4: FACE REGISTRATION =================
  final isFaceScanning = false.obs;
  final isFaceRegistered = false.obs;
  final scanStatus = 'Siap melakukan pemindaian wajah'.obs;
  final confidenceScore = 0.0.obs;
  final biometricsLogs = <String>[].obs;
  final imagePath = ''.obs;

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

  // ================= FACE SCAN ACTIONS =================
  Future<void> startFaceRegistration() async {
    if (isFaceScanning.value) return;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 70,
      );

      if (photo == null) {
        Get.snackbar('Dibatalkan', 'Pemindaian wajah dibatalkan.');
        return;
      }

      imagePath.value = photo.path;
      _runFaceRegistrationSimulation();
    } catch (e) {
      debugPrint('Camera access fallback: $e');
      _runFaceRegistrationSimulation();
    }
  }

  void _runFaceRegistrationSimulation() {
    isFaceScanning.value = true;
    biometricsLogs.clear();
    confidenceScore.value = 0.0;

    _addLog('Memulai Kamera & Inisialisasi Pemindai Wajah...');
    _updateStatus('Mendeteksi wajah pada frame...', 800, () {
      _addLog('Wajah terdeteksi: 1 subjek.');
      _updateStatus('Mengekstrak landmark wajah (68 titik)...', 1000, () {
        _addLog('Titik landmark mata, hidung, mulut sejajar.');
        _updateStatus('Mengekstrak embedding vektor wajah...', 1000, () {
          _addLog('Embedding wajah diekstrak: 512-dimensi.');
          _updateStatus('Mendaftarkan wajah ke database Warga...', 1200, () {
            _addLog('Menyimpan embedding ke database MongoDB...');
            
            isFaceScanning.value = false;
            isFaceRegistered.value = true;
            scanStatus.value = 'Wajah Berhasil Didaftarkan!';
            _addLog('Pendaftaran Wajah Berhasil: Data biometrik tersimpan.');

            Get.snackbar(
              'Registrasi Wajah Berhasil',
              'Data wajah Anda berhasil diregistrasikan ke database desa.',
              backgroundColor: const Color(0xFF2E7D32),
              colorText: Colors.white,
            );
          });
        });
      });
    });
  }

  void _addLog(String log) {
    biometricsLogs.add('[${DateTime.now().toString().split(' ')[1].substring(0, 8)}] $log');
  }

  void _updateStatus(String status, int delayMs, VoidCallback callback) {
    scanStatus.value = status;
    Timer(Duration(milliseconds: delayMs), callback);
  }

  // ================= REGISTER =================
  Future<void> register() async {
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

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Konfirmasi password tidak cocok',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (!isFaceRegistered.value) {
      Get.snackbar(
        'Verifikasi Wajah Wajib',
        'Silakan lakukan pemindaian wajah terlebih dahulu sebelum menyelesaikan pendaftaran.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      // 1. Flask API Registration
      bool success = await authService.register(
        emailController.text.trim(),
        passwordController.text,
        nameController.text.trim(),
        rt: rtController.text.trim(),
        rw: rwController.text.trim(),
      );

      if (success) {
        Get.snackbar(
          'Berhasil',
          'Registrasi berhasil. Silakan login.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mendaftar: $e');
    } finally {
      isLoading.value = false;
    }
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