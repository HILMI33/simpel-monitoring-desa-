import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:camera/camera.dart';
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  // ================= COLOR =================
  static const _primaryGreen = Color(0xFF2D5A2D);
  static const _lightGreen = Color(0xFF4A7C4A);
  static const _bgColor = Color(0xFFF7F8F5);
  static const _borderColor = Color(0xFFE0E5DC);

  // ================= STEP LABEL =================
  static const _steps = [
    "Akun",
    "Kontak",
    "Keamanan",
<<<<<<< HEAD
    "Email",
    "Wajah"
=======
    "Verifikasi"
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // ================= HEADER =================
          _buildHeader(context),

          // ================= STEP INDICATOR =================
          Obx(() => _buildStepIndicator(
                controller.currentStep.value,
              )),

          // ================= STEP CONTENT =================
          Expanded(
            child: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),

                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.04, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },

                child: _buildStepContent(
                  context,
                  controller.currentStep.value,
                ),
              ),
            ),
          ),

          // ================= BOTTOM NAV =================
          _buildBottomNav(),
        ],
      ),
    );
  }

  // =====================================================
  // HEADER
  // =====================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: _primaryGreen,

      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 16,
        left: 8,
        right: 24,
      ),

      child: Row(
        children: [
          // ================= BACK BUTTON =================
          IconButton(
            onPressed: () {
              if (controller.currentStep.value > 0) {
                controller.currentStep.value--;
              } else {
                Get.back();
              }
            },

            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 2),

          // ================= LOGO =================
          Container(
            width: 34,
            height: 34,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),

            child: const Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 12),

          // ================= TITLE =================
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
<<<<<<< HEAD
                "SIMPEL",
=======
                "SMART VILLAGE",
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),

              Text(
                "Pendaftaran Warga",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STEP INDICATOR
  // =====================================================

  Widget _buildStepIndicator(int current) {
    return Container(
      color: Colors.white,

      padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),

      child: Column(
        children: [
          // ================= PROGRESS BAR =================
          ClipRRect(
            borderRadius: BorderRadius.circular(4),

            child: LinearProgressIndicator(
              value: (current + 1) / _steps.length,

              backgroundColor: const Color(0xFFE8ECE5),

              valueColor:
                  const AlwaysStoppedAnimation<Color>(_primaryGreen),

              minHeight: 4,
            ),
          ),

          const SizedBox(height: 12),

          // ================= STEP LIST =================
          Row(
<<<<<<< HEAD
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_steps.length * 2 - 1, (index) {
              if (index % 2 != 0) {
                // ================= LINE =================
                final int i = index ~/ 2;
                return Expanded(
                  flex: 1,
                  child: Container(
                    height: 1.5,
                    margin: const EdgeInsets.only(top: 15, left: 2, right: 2),
                    color: i < current ? _primaryGreen : const Color(0xFFE8ECE5),
                  ),
                );
              }

              final int i = index ~/ 2;
              final done = i < current;
              final active = i == current;

              return Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // ================= STEP CIRCLE =================
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),

                      width: 30,
                      height: 30,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: done || active
                            ? _primaryGreen
                            : const Color(0xFFE8ECE5),
                      ),

                      child: Center(
                        child: done
                            ? const Icon(
                                Icons.check_rounded,
                                size: 14,
                                color: Colors.white,
                              )
                            : Text(
                                "${i + 1}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: active
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // ================= STEP LABEL =================
                    Text(
                      _steps[i],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,

                        fontWeight: active || done
                            ? FontWeight.w700
                            : FontWeight.w500,

                        color: active || done
                            ? _primaryGreen
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
=======
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: List.generate(_steps.length, (i) {
              final done = i < current;
              final active = i == current;

              return Row(
                children: [
                  Column(
                    children: [
                      // ================= STEP CIRCLE =================
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),

                        width: 30,
                        height: 30,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: done || active
                              ? _primaryGreen
                              : const Color(0xFFE8ECE5),
                        ),

                        child: Center(
                          child: done
                              ? const Icon(
                                  Icons.check_rounded,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : Text(
                                  "${i + 1}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: active
                                        ? Colors.white
                                        : Colors.grey.shade400,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // ================= STEP LABEL =================
                      Text(
                        _steps[i],

                        style: TextStyle(
                          fontSize: 11,

                          fontWeight: active || done
                              ? FontWeight.w700
                              : FontWeight.w500,

                          color: active || done
                              ? _primaryGreen
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),

                  // ================= LINE =================
                  if (i < _steps.length - 1)
                    Container(
                      width: 38,
                      height: 1.5,

                      margin: const EdgeInsets.only(bottom: 18),

                      color: i < current
                          ? _primaryGreen
                          : const Color(0xFFE8ECE5),
                    ),
                ],
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
              );
            }),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STEP CONTENT
  // =====================================================

  Widget _buildStepContent(BuildContext context, int step) {
    switch (step) {
      case 0:
        return _stepAkun(key: const ValueKey(0));

      case 1:
        return _stepKontak(key: const ValueKey(1));

      case 2:
        return _stepKeamanan(key: const ValueKey(2));

      case 3:
<<<<<<< HEAD
        return _stepVerifikasiEmail(context, key: const ValueKey(3));

      case 4:
        return _stepVerifikasi(
          context,
          key: const ValueKey(4),
=======
        return _stepVerifikasi(
          context,
          key: const ValueKey(3),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
        );

      default:
        return const SizedBox();
    }
  }

  // =====================================================
  // STEP 1 - AKUN
  // =====================================================

  Widget _stepAkun({Key? key}) {
    return SingleChildScrollView(
      key: key,

      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStepTitle(
            "Data Akun",
            "Masukkan identitas akun Anda",
            Icons.person_outline_rounded,
          ),

          const SizedBox(height: 24),

          // ================= NAMA =================
          _buildFieldLabel("Nama Lengkap"),

          const SizedBox(height: 8),

          _buildTextField(
            ctrl: controller.nameController,
            hint: "Masukkan nama lengkap",
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
          ),

          const SizedBox(height: 18),

          // ================= EMAIL =================
          _buildFieldLabel("Email"),

          const SizedBox(height: 8),

          _buildTextField(
            ctrl: controller.emailController,
            hint: "Masukkan email aktif",
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STEP 2 - KONTAK
  // =====================================================

  Widget _stepKontak({Key? key}) {
    return SingleChildScrollView(
      key: key,

      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStepTitle(
            "Kontak",
            "Masukkan nomor telepon dan wilayah",
            Icons.phone_outlined,
          ),

          const SizedBox(height: 24),

          // ================= PHONE =================
          _buildFieldLabel("No. Telepon / WhatsApp"),

          const SizedBox(height: 8),

          _buildTextField(
            ctrl: controller.phoneController,
            hint: "8123456789",
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,

            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],

            prefix: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),

              margin: const EdgeInsets.only(right: 8),

              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: _borderColor,
                    width: 1.2,
                  ),
                ),
              ),

              child: const Text(
                "+62",

                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF444444),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ================= RT & RW =================
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("RT"),

                    const SizedBox(height: 8),

                    _buildTextField(
                      ctrl: controller.rtController,
                      hint: "001",
                      icon: Icons.home_outlined,
                      keyboardType: TextInputType.number,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("RW"),

                    const SizedBox(height: 8),

                    _buildTextField(
                      ctrl: controller.rwController,
                      hint: "002",
                      icon: Icons.location_city_outlined,
                      keyboardType: TextInputType.number,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ================= INFO BOX =================
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xFFF4F8F2),

              borderRadius: BorderRadius.circular(14),

              border: Border.all(
                color: const Color(0xFFDDE8D8),
              ),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: _lightGreen,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "Nomor telepon digunakan untuk verifikasi akun dan notifikasi aplikasi.",
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STEP 3 - PASSWORD
  // =====================================================

  Widget _stepKeamanan({Key? key}) {
    return SingleChildScrollView(
      key: key,

      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStepTitle(
            "Keamanan Akun",
            "Buat password yang aman",
            Icons.lock_outline_rounded,
          ),

          const SizedBox(height: 24),

          // ================= PASSWORD =================
          _buildFieldLabel("Password"),

          const SizedBox(height: 8),

          Obx(
            () => _buildTextField(
              ctrl: controller.passwordController,
              hint: "Masukkan password",
              icon: Icons.lock_outline_rounded,

              obscureText: controller.isPasswordHidden.value,

              suffixIcon: _eyeButton(
                hidden: controller.isPasswordHidden.value,
                onTap: () => controller.isPasswordHidden.toggle(),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ================= CONFIRM PASSWORD =================
          _buildFieldLabel("Konfirmasi Password"),

          const SizedBox(height: 8),

          Obx(
            () => _buildTextField(
              ctrl: controller.confirmPasswordController,
              hint: "Ulangi password",
              icon: Icons.lock_outline_rounded,

              obscureText:
                  controller.isConfirmPasswordHidden.value,

              suffixIcon: _eyeButton(
                hidden:
                    controller.isConfirmPasswordHidden.value,

                onTap: () =>
                    controller.isConfirmPasswordHidden.toggle(),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ================= PASSWORD INFO =================
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: _bgColor,

              borderRadius: BorderRadius.circular(14),

              border: Border.all(
                color: _borderColor,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Syarat Password",

                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF444444),
                  ),
                ),

                const SizedBox(height: 8),

                _passwordRule("Minimal 8 karakter"),
                _passwordRule("Huruf besar & kecil"),
                _passwordRule("Mengandung angka"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordRule(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),

      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 14,
            color: _lightGreen,
          ),

          const SizedBox(width: 7),

          Text(
            text,

            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _stepVerifikasiEmail(
    BuildContext context, {
    Key? key,
  }) {
    return SingleChildScrollView(
      key: key,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStepTitle(
            "Verifikasi Email",
            "Verifikasi alamat email Anda untuk melanjutkan",
            Icons.mark_email_read_outlined,
          ),
          const SizedBox(height: 24),
          Text(
            "Kode OTP akan dikirimkan ke alamat email berikut:",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.mail_outline_rounded, color: _primaryGreen, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    controller.emailController.text,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Obx(() {
            if (!controller.isOtpSent.value) {
              return SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: controller.isLoading.value ? null : () => controller.sendOtp(),
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  label: const Text(
                    'Kirim Kode OTP',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFieldLabel("Masukkan 6-Digit OTP"),
                const SizedBox(height: 8),
                _buildTextField(
                  ctrl: controller.otpController,
                  hint: "Contoh: 123456",
                  icon: Icons.vpn_key_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controller.isOtpVerified.value) {
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F8F2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDDE8D8)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Email berhasil diverifikasi!",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: _primaryGreen, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: controller.otpCooldown.value > 0 || controller.isLoading.value
                                ? null
                                : () => controller.sendOtp(),
                            child: Obx(() => Text(
                              controller.otpCooldown.value > 0
                                  ? 'Kirim Ulang (${controller.otpCooldown.value}s)'
                                  : 'Kirim Ulang OTP',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _primaryGreen,
                              ),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: controller.isLoading.value ? null : () => controller.verifyOtp(),
                            child: const Text(
                              'Verifikasi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
  Widget _stepVerifikasi(
    BuildContext context, {
    Key? key,
  }) {
    return SingleChildScrollView(
      key: key,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStepTitle(
            "Registrasi Wajah",
            "Daftarkan wajah Anda untuk verifikasi masuk",
            Icons.face_retouching_natural_rounded,
          ),
          const SizedBox(height: 24),
<<<<<<< HEAD

          Obx(() => Text(
            controller.scanStatus.value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: controller.isFaceDetected.value ? FontWeight.bold : FontWeight.normal,
              color: controller.isFaceDetected.value ? Colors.green.shade700 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          )),
          const SizedBox(height: 12),
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
          
          // Circular Face Scanner Circle
          _buildFaceScannerCircle(),
          
          const SizedBox(height: 24),
          Obx(() {
            if (controller.isFaceScanning.value) {
              return const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _primaryGreen,
                ),
              );
            }
            if (controller.isFaceRegistered.value) {
              return Icon(Icons.check_circle_rounded, color: Colors.green.shade700, size: 36);
            }
            return SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: controller.isFaceDetected.value ? _primaryGreen : Colors.grey.shade400,
=======
                  backgroundColor: _primaryGreen,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
<<<<<<< HEAD
                onPressed: controller.isFaceDetected.value ? controller.startFaceRegistration : null,
=======
                onPressed: controller.startFaceRegistration,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                icon: const Icon(Icons.face_retouching_natural_rounded, color: Colors.white),
                label: const Text(
                  'Ambil Foto & Pindai Wajah',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
<<<<<<< HEAD
          
          const SizedBox(height: 24),
          _buildDiagnosticLogs(),
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
        ],
      ),
    );
  }

  // Circular Face Scanner Widget
  Widget _buildFaceScannerCircle() {
<<<<<<< HEAD
    return Obx(() {
      final borderColor = controller.isFaceDetected.value ? Colors.greenAccent : _primaryGreen;
      return Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.15),
              blurRadius: 16,
              spreadRadius: 4,
            ),
          ],
        ),
        child: ClipOval(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // User Photo or Live Camera
              if (controller.imagePath.value.isNotEmpty)
                kIsWeb
                    ? Image.network(controller.imagePath.value, fit: BoxFit.cover)
                    : Image.file(File(controller.imagePath.value), fit: BoxFit.cover)
              else if (controller.isCameraInitialized.value && controller.cameraController != null)
                Transform.scale(
                  scale: 1.3,
                  child: Center(child: CameraPreview(controller.cameraController!)),
                )
              else
                Container(
                  color: Colors.grey.shade100,
                  child: Icon(
                    Icons.person_pin_rounded,
                    color: Colors.grey.shade400,
                    size: 100,
                  ),
                ),
              
              // Cyber mesh grid vector layer
              Opacity(
                opacity: 0.15,
                child: Image.network(
                  'https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=200',
                  fit: BoxFit.cover,
                  errorBuilder: (context, err, stack) => const SizedBox(),
                ),
              ),

              // Scanning laser line animation
              if (controller.isFaceScanning.value || (!controller.isFaceDetected.value && controller.imagePath.value.isEmpty))
                const _ScanningLaserLine(),
            ],
          ),
        ),
      );
    });
=======
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _primaryGreen,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryGreen.withOpacity(0.15),
            blurRadius: 16,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // User Photo or Mock Avatar
            Obx(() {
              if (controller.imagePath.value.isNotEmpty) {
                if (kIsWeb) {
                  return Image.network(
                    controller.imagePath.value,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.file(
                    File(controller.imagePath.value),
                    fit: BoxFit.cover,
                  );
                }
              }
              return Container(
                color: Colors.grey.shade100,
                child: Icon(
                  Icons.person_pin_rounded,
                  color: Colors.grey.shade400,
                  size: 100,
                ),
              );
            }),
            
            // Cyber mesh grid vector layer
            Opacity(
              opacity: 0.15,
              child: Image.network(
                'https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=200',
                fit: BoxFit.cover,
                errorBuilder: (context, err, stack) => const SizedBox(),
              ),
            ),

            // Scanning laser line animation
            Obx(() {
              if (controller.isFaceScanning.value) {
                return const _ScanningLaserLine();
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
  }

  // Diagnostic Logs Console
  Widget _buildDiagnosticLogs() {
    return Obx(() {
      if (controller.biometricsLogs.isEmpty) return const SizedBox();
      return Card(
        color: const Color(0xFF0F172A), // Slate-900 black console
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.terminal_rounded, color: Colors.greenAccent, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'DIAGNOSTIC CONSOLE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                      letterSpacing: 1.0,
                      fontFamily: 'Courier',
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white12, height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.biometricsLogs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      controller.biometricsLogs[index],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFC0FCD0), // Light neon green terminal text
                        fontFamily: 'Courier',
                        height: 1.3,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  // =====================================================
  // BOTTOM NAVIGATION
  // =====================================================

  Widget _buildBottomNav() {
    return Obx(() {
      final step = controller.currentStep.value;
      final isLast = step == _steps.length - 1;

      return Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),

        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ================= BUTTON =================
            Container(
              height: 54,

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    _primaryGreen,
                    _lightGreen,
                  ],
                ),

                borderRadius: BorderRadius.circular(14),

                boxShadow: [
                  BoxShadow(
                    color: _primaryGreen.withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Material(
                color: Colors.transparent,

                child: InkWell(
                  borderRadius: BorderRadius.circular(14),

                  onTap: () {
                    if (isLast) {
                      controller.register();
                    } else {
<<<<<<< HEAD
                      if (controller.validateCurrentStep()) {
                        controller.currentStep.value++;
                      }
=======
                      controller.currentStep.value++;
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                    }
                  },

                  child: Center(
                    child: Text(
                      isLast
                          ? "Daftar Sekarang"
                          : "Lanjut",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ================= LOGIN =================
            if (step == 0) ...[
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun? ",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Get.back(),

                    child: const Text(
                      "Masuk",

                      style: TextStyle(
                        fontSize: 13,
                        color: _primaryGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }

  // =====================================================
  // STEP TITLE
  // =====================================================

  Widget _buildStepTitle(
    String title,
    String sub,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,

          decoration: BoxDecoration(
            color: const Color(0xFFF0F7F0),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(
            icon,
            color: _primaryGreen,
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A2A1A),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                sub,

                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // FIELD LABEL
  // =====================================================

  Widget _buildFieldLabel(String label) {
    return Text(
      label,

      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF444444),
      ),
    );
  }

  // =====================================================
  // TEXT FIELD
  // =====================================================

  Widget _buildTextField({
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    Widget? prefix,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: _borderColor,
          width: 1.4,
        ),
      ),

      child: TextField(
        controller: ctrl,

        obscureText: obscureText,

        keyboardType: keyboardType,

        maxLines: maxLines,

        cursorColor: _primaryGreen,

        inputFormatters: inputFormatters,

        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF1A2A1A),
        ),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFBBBBBB),
          ),

          border: InputBorder.none,

          prefixIcon: prefix == null
              ? Icon(
                  icon,
                  size: 18,
                  color: Colors.grey.shade400,
                )
              : null,

          prefix: prefix,

          suffixIcon: suffixIcon,

          contentPadding: EdgeInsets.symmetric(
            horizontal: prefix != null ? 0 : 16,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // EYE BUTTON
  // =====================================================

  Widget _eyeButton({
    required bool hidden,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,

      icon: Icon(
        hidden
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,

        size: 18,
        color: Colors.grey.shade400,
      ),
    );
  }
}

// --- Stateful Laser Scanner animation class ---
class _ScanningLaserLine extends StatefulWidget {
  const _ScanningLaserLine();

  @override
  State<_ScanningLaserLine> createState() => _ScanningLaserLineState();
}

class _ScanningLaserLineState extends State<_ScanningLaserLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10.0, end: 190.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: _animation.value,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.8),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.greenAccent.withOpacity(0.3),
                          Colors.greenAccent.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}