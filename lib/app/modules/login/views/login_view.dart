import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../../../routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  // ================= CONTROLLER =================

  late final LoginController _loginController;

  // ================= UI STATE =================

  bool _obscurePassword = true;

  // ================= ANIMATION =================

  late AnimationController _animationController;

  late Animation<double> _fadeIn;

  late Animation<Offset> _slideUp;

  // ================= COLOR =================

  static const _primaryGreen = Color(0xFF2D5A2D);

  static const _lightGreen = Color(0xFF4A7C4A);

  static const _bgColor = Color(0xFFF7F8F5);

  @override
  void initState() {
    super.initState();
    _loginController = Get.find<LoginController>();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideUp = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,

          child: SlideTransition(
            position: _slideUp,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HERO
                  _buildHeroSection(size),

                  // FORM
                  _buildFormSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // HERO SECTION
  // =====================================================

  Widget _buildHeroSection(Size size) {
    return SizedBox(
      height: size.height * 0.38,

      child: Stack(
        fit: StackFit.expand,

        children: [
          // ================= IMAGE =================
          Image.asset("assets/images/bongkok.jpg", fit: BoxFit.cover),

          // ================= OVERLAY =================
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                colors: [
                  Color(0x99000000),
                  Color(0x22000000),
                  Color(0xCC0A190A),
                ],
              ),
            ),
          ),

          // ================= TOP TITLE =================
          Positioned(
            top: 24,
            left: 24,
            right: 24,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "SIMPEL",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,

                    letterSpacing: 1.2,

                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black54,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Laporan, Informasi & Pembangunan Desa",

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),

                    fontSize: 12,

                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // ================= BOTTOM TEXT =================
          Positioned(
            left: 24,
            bottom: 28,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.20),

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),

                  child: const Text(
                    "DESA BONGKOK",

                    style: TextStyle(
                      color: Color(0xFFC8FFC8),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "Selamat\nDatang",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Portal digital warga desa",

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),

                    fontSize: 13,
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
  // FORM
  // =====================================================

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),

      child: Column(
        children: [
          // ================= TITLE =================
          Row(
            children: [
              Container(
                width: 4,
                height: 18,

                decoration: BoxDecoration(
                  color: _primaryGreen,

                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(width: 8),

              const Text(
                "MASUK KE AKUN ANDA",

                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                  color: _lightGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // EMAIL
          _buildFieldLabel("Email / No. HP"),

          const SizedBox(height: 8),

          _buildTextField(
            controller: _loginController.emailController,

            hint: "Masukkan email atau no. hp",

            icon: Icons.mail_outline_rounded,
          ),

          const SizedBox(height: 18),

          // PASSWORD
          _buildFieldLabel("Password"),

          const SizedBox(height: 8),

          _buildTextField(
            controller: _loginController.passwordController,

            hint: "Masukkan password",

            icon: Icons.lock_outline_rounded,

            isPassword: true,
          ),

          // FORGOT
          Align(
            alignment: Alignment.centerRight,

            child: TextButton(
              onPressed: () {},

              child: const Text(
                "Lupa Password?",

                style: TextStyle(color: _primaryGreen),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // LOGIN BUTTON
          _buildLoginButton(),

          const SizedBox(height: 24),

          // DIVIDER
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),

                child: Text(
                  "atau",

                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),

              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),

          const SizedBox(height: 20),

          // GOOGLE BUTTON
          _buildGoogleButton(),

          const SizedBox(height: 24),

          // REGISTER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Belum punya akun?",

                style: TextStyle(color: Colors.grey.shade600),
              ),

              const SizedBox(width: 5),

              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.REGISTER);
                },

                child: const Text(
                  "Daftar",

                  style: TextStyle(
                    color: _primaryGreen,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // LABEL
  // =====================================================

  Widget _buildFieldLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        text,

        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  // =====================================================
  // TEXTFIELD
  // =====================================================

  Widget _buildTextField({
    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _bgColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: TextField(
        controller: controller,

        obscureText: isPassword ? _obscurePassword : false,

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),

          prefixIcon: Icon(icon, color: _lightGreen),

          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,

                    color: Colors.grey.shade500,
                  ),

                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,

          border: InputBorder.none,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // LOGIN BUTTON
  // =====================================================

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryGreen,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        onPressed: () {
          _loginController.login();
        },

        child: Obx(
          () => _loginController.isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  // =====================================================
  // GOOGLE BUTTON
  // =====================================================

  Widget _buildGoogleButton() {
    return OutlinedButton(
      onPressed: () {
        _loginController.loginGoogle();
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 54),
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/google_logo.png", width: 22, height: 22),
          const SizedBox(width: 12),
          const Text(
            "Masuk dengan Google",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
