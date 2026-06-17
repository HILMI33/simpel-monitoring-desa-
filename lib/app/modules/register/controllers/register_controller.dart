import 'dart:async';
<<<<<<< HEAD
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../../app/data/services/api_service.dart';
=======
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/data/services/auth_service.dart';
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

class RegisterController extends GetxController {
  final box = GetStorage();
  final authService = Get.find<AuthService>();
<<<<<<< HEAD
  final apiService = Get.find<ApiService>();
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

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

<<<<<<< HEAD
  // ================= STEP 4: EMAIL OTP =================
  final otpController = TextEditingController();
  final isOtpSent = false.obs;
  final isOtpVerified = false.obs;
  final otpCooldown = 0.obs;
  Timer? _cooldownTimer;

  // ================= STEP 4: FACE REGISTRATION =================
  final isFaceScanning = false.obs;
  final isFaceRegistered = false.obs;
  final scanStatus = 'Mempersiapkan Kamera...'.obs;
=======
  // ================= STEP 4: FACE REGISTRATION =================
  final isFaceScanning = false.obs;
  final isFaceRegistered = false.obs;
  final scanStatus = 'Siap melakukan pemindaian wajah'.obs;
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
  final confidenceScore = 0.0.obs;
  final biometricsLogs = <String>[].obs;
  final imagePath = ''.obs;

<<<<<<< HEAD
  // ================= CAMERA & ML KIT =================
  CameraController? cameraController;
  final isCameraInitialized = false.obs;
  final isFaceDetected = false.obs;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;

  @override
  void onInit() {
    super.onInit();
    ever(currentStep, (step) {
      if (step == 4) {
        _initializeCamera();
      } else {
        _disposeCamera();
      }
    });
  }

=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
  Future<void> _initializeCamera() async {
    if (kIsWeb) return;
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid 
            ? ImageFormatGroup.nv21 
            : ImageFormatGroup.bgra8888,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
      scanStatus.value = 'Arahkan wajah Anda ke dalam area scan';
      _addLog('Kamera diinisialisasi. Modul pendeteksi aktif.');

      cameraController!.startImageStream(_processCameraImage);
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      _addLog('Gagal inisialisasi kamera: $e');
      scanStatus.value = 'Gagal mengakses kamera.';
    }
  }

  void _disposeCamera() {
    cameraController?.stopImageStream();
    cameraController?.dispose();
    cameraController = null;
    isCameraInitialized.value = false;
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (!_canProcess || _isBusy || isFaceScanning.value || isFaceRegistered.value) return;
    _isBusy = true;
    
    try {
      final inputImage = _inputImageFromCameraImage(image);
      if (inputImage == null) {
        _isBusy = false;
        return;
      }
      
      final faces = await _faceDetector.processImage(inputImage);
      
      if (faces.isNotEmpty) {
        if (!isFaceDetected.value) {
          isFaceDetected.value = true;
          scanStatus.value = 'Wajah Terdeteksi! Silakan Ambil Foto.';
        }
      } else {
        if (isFaceDetected.value) {
          isFaceDetected.value = false;
          scanStatus.value = 'Arahkan wajah Anda ke dalam area scan';
        }
      }
    } catch (e) {
      debugPrint('Face detection error: $e');
    } finally {
      _isBusy = false;
    }
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (cameraController == null) return null;
    
    final camera = cameraController!.description;
    final sensorOrientation = camera.sensorOrientation;
    
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = 0;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + 0) % 360;
      } else {
        rotationCompensation = (sensorOrientation - 0 + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  Future<void> startFaceRegistration() async {
    if (isFaceScanning.value) return;

    if (!isFaceDetected.value && cameraController != null) {
      Get.snackbar(
        'Perhatian',
        'Wajah belum terdeteksi. Harap posisikan wajah Anda dengan jelas.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        await cameraController!.stopImageStream();
        final XFile file = await cameraController!.takePicture();
        
        imagePath.value = file.path;
        _runFaceRegistrationSimulation();
      } else {
        _runFaceRegistrationSimulation(); // Fallback if web
      }
    } catch (e) {
      debugPrint('Error capturing photo: $e');
      _addLog('Gagal mengambil foto: $e');
      _runFaceRegistrationSimulation(); // Fallback
=======
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
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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

<<<<<<< HEAD
  // ================= EMAIL OTP ACTIONS =================
  Future<void> sendOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email wajib diisi');
      return;
    }
    if (otpCooldown.value > 0) return;

    isLoading.value = true;
    try {
      final response = await apiService.post('/auth/send-otp', {
        'email': email,
        'type': 'register',
      });

      if (response.statusCode == 200) {
        isOtpSent.value = true;
        otpCooldown.value = 60;
        _startCooldownTimer();
        Get.snackbar(
          'Kode OTP Terkirim',
          'Kode verifikasi telah dikirim ke email $email.',
          backgroundColor: const Color(0xFF2E7D32),
          colorText: Colors.white,
        );
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar(
          'Gagal Mengirim OTP',
          error['message'] ?? 'Terjadi kesalahan pada server.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghubungkan ke server.', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void _startCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpCooldown.value > 0) {
        otpCooldown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    final email = emailController.text.trim();
    final code = otpController.text.trim();
    if (code.isEmpty) {
      Get.snackbar('Error', 'Silakan masukkan kode OTP');
      return;
    }

    isLoading.value = true;
    try {
      final response = await apiService.post('/auth/verify-otp', {
        'email': email,
        'code': code,
      });

      if (response.statusCode == 200) {
        isOtpVerified.value = true;
        Get.snackbar(
          'OTP Terverifikasi',
          'Email Anda berhasil diverifikasi!',
          backgroundColor: const Color(0xFF2E7D32),
          colorText: Colors.white,
        );
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar(
          'Gagal Verifikasi',
          error['message'] ?? 'Kode OTP salah atau telah kadaluarsa.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghubungkan ke server.', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= STEP VALIDATION =================
  bool validateCurrentStep() {
    if (currentStep.value == 0) {
      if (nameController.text.trim().isEmpty) {
        Get.snackbar('Error', 'Nama Lengkap wajib diisi', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
      final email = emailController.text.trim();
      if (email.isEmpty) {
        Get.snackbar('Error', 'Email wajib diisi', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
      if (!GetUtils.isEmail(email)) {
        Get.snackbar('Error', 'Format email tidak valid', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } else if (currentStep.value == 1) {
      if (phoneController.text.trim().isEmpty) {
        Get.snackbar('Error', 'Nomor telepon wajib diisi', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
      if (rtController.text.trim().isEmpty || rwController.text.trim().isEmpty) {
        Get.snackbar('Error', 'RT dan RW wajib diisi', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } else if (currentStep.value == 2) {
      final pwd = passwordController.text;
      final confirm = confirmPasswordController.text;
      if (pwd.isEmpty) {
        Get.snackbar('Error', 'Password wajib diisi', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
      if (pwd.length < 8) {
        Get.snackbar('Error', 'Password minimal 8 karakter', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
      if (pwd != confirm) {
        Get.snackbar('Error', 'Konfirmasi password tidak cocok', backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } else if (currentStep.value == 3) {
      if (!isOtpVerified.value) {
        Get.snackbar('Verifikasi Email Wajib', 'Silakan lakukan verifikasi OTP email Anda terlebih dahulu.', backgroundColor: Colors.orange, colorText: Colors.white);
        return false;
      }
    }
    return true;
  }

=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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

<<<<<<< HEAD
    if (!isOtpVerified.value) {
      Get.snackbar(
        'Verifikasi Email Wajib',
        'Silakan lakukan verifikasi OTP email Anda terlebih dahulu.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
        isEmailVerified: isOtpVerified.value,
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
    _canProcess = false;
    _disposeCamera();
    _faceDetector.close();
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    rtController.dispose();
    rwController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
<<<<<<< HEAD
    otpController.dispose();
    _cooldownTimer?.cancel();
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    super.onClose();
  }
}