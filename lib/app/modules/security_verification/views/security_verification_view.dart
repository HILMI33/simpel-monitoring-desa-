import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../controllers/security_verification_controller.dart';

class SecurityVerificationView extends GetView<SecurityVerificationController> {
  const SecurityVerificationView({super.key});

  static const _primaryGreen = Color(0xFF2D5A2D);
  static const _accentGreen = Color(0xFF4A7C4A);
  static const _bgColor = Color(0xFFF7F8F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            controller.authService.logout();
          },
        ),
        title: Obx(() => Text(
          controller.isRegMode ? 'Registrasi Wajah' : 'Verifikasi Keamanan',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        )),
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() => controller.currentStep.value == 1
                ? _buildOtpStepView(context)
                : _buildFaceStepView(context)),
          ),
        ),
      ),
    );
  }


  // --- Step 2: FaceNet Biometric Scanner View ---
  Widget _buildFaceStepView(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.grey.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Obx(() => Text(
                  controller.isRegMode ? 'Registrasi Wajah Baru' : 'Pemindaian Wajah',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )),
                const SizedBox(height: 6),
                Obx(() => Text(
                  controller.scanStatus.value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: controller.isFaceDetected.value ? FontWeight.bold : FontWeight.normal,
                    color: controller.isFaceDetected.value ? Colors.green.shade700 : Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                )),
                const SizedBox(height: 24),
                
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
                  if (controller.isFaceVerified.value) {
                    return Icon(Icons.check_circle_rounded, color: Colors.green.shade700, size: 36);
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isFaceDetected.value ? _primaryGreen : Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: controller.isFaceDetected.value ? controller.startFaceVerification : null,
                      icon: const Icon(Icons.face_retouching_natural_rounded, color: Colors.white),
                      label: Text(
                        controller.isRegMode ? 'Ambil Foto & Registrasi' : 'Ambil Foto & Pindai',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Face Scanner with Horizontal Laser Animation ---
  Widget _buildFaceScannerCircle() {
    return Obx(() {
      final borderColor = controller.isFaceDetected.value ? Colors.greenAccent : _primaryGreen;
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: ClipOval(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Live Camera Preview or Captured Image
              if (controller.imagePath.value.isNotEmpty)
                kIsWeb
                    ? Image.network(controller.imagePath.value, fit: BoxFit.cover)
                    : Image.file(File(controller.imagePath.value), fit: BoxFit.cover)
              else if (controller.isCameraInitialized.value && controller.cameraController != null)
                Transform.scale(
                  scale: 1.3, // zoom slightly to fill circle
                  child: Center(child: CameraPreview(controller.cameraController!)),
                )
              else
                Container(
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(color: _primaryGreen),
                  ),
                ),
              
              // Cyber mesh grid vector layer
              Opacity(
                opacity: 0.25,
                child: Image.network(
                  'https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=200', // A mesh-like background texture
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
  }

  // --- High-Tech Retro Diagnostic Terminal Cards ---
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Obx(() {
                    if (controller.confidenceScore.value > 0.0) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'SCORE: ${(controller.confidenceScore.value * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                            fontFamily: 'Courier',
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
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

  // --- Step 1: Email OTP View ---
  Widget _buildOtpStepView(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.grey.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    color: _primaryGreen,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Verifikasi Email Anda',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan kode OTP yang telah kami kirimkan ke email:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Center(
                  child: Obx(() => Text(
                    controller.userEmail,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )),
                ),
                const SizedBox(height: 24),
                
                TextField(
                  controller: controller.otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Masukkan 6 Digit OTP',
                    prefixIcon: const Icon(Icons.vpn_key_outlined, color: _primaryGreen),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: _primaryGreen, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
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
                          height: 52,
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
                                  : 'Kirim Ulang',
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
                          height: 52,
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
            ),
          ),
        ),
      ],
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

    _animation = Tween<double>(begin: -10.0, end: 210.0).animate(
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
