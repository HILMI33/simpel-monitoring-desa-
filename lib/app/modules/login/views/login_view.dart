<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../../../routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
<<<<<<< HEAD
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
=======
  State<LoginView> createState() =>
      _LoginViewState();
}

class _LoginViewState
    extends State<LoginView>
    with SingleTickerProviderStateMixin {

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
  // ================= CONTROLLER =================

  late final LoginController _loginController;

  // ================= UI STATE =================

  bool _obscurePassword = true;

  // ================= ANIMATION =================

<<<<<<< HEAD
  late AnimationController _animationController;
=======
  late AnimationController
      _animationController;
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

  late Animation<double> _fadeIn;

  late Animation<Offset> _slideUp;

  // ================= COLOR =================

<<<<<<< HEAD
  static const _primaryGreen = Color(0xFF2D5A2D);

  static const _lightGreen = Color(0xFF4A7C4A);

  static const _bgColor = Color(0xFFF7F8F5);
=======
  static const _primaryGreen =
      Color(0xFF2D5A2D);

  static const _lightGreen =
      Color(0xFF4A7C4A);

  static const _bgColor =
      Color(0xFFF7F8F5);
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

  @override
  void initState() {
    super.initState();
    _loginController = Get.find<LoginController>();

<<<<<<< HEAD
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
=======
    _animationController =
        AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 900),
    );

    _fadeIn =
        Tween<double>(begin: 0, end: 1)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final size = MediaQuery.of(context).size;
=======

    final size =
        MediaQuery.of(context).size;
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

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
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    return SizedBox(
      height: size.height * 0.38,

      child: Stack(
        fit: StackFit.expand,

        children: [
<<<<<<< HEAD
          // ================= IMAGE =================
          Image.asset("assets/images/bongkok.jpg", fit: BoxFit.cover),

          // ================= OVERLAY =================
          Container(
            decoration: const BoxDecoration(
=======

          // ================= IMAGE =================

          Image.asset(
            "assets/images/bongkok.jpg",
            fit: BoxFit.cover,
          ),

          // ================= OVERLAY =================

          Container(
            decoration:
                const BoxDecoration(
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
          Positioned(
            top: 24,
            left: 24,
            right: 24,

            child: Column(
<<<<<<< HEAD
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "SIMPEL",
=======
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Text(
                  "SMART VILLAGE",
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
<<<<<<< HEAD
                    fontWeight: FontWeight.w700,
=======
                    fontWeight:
                        FontWeight.w700,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

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
<<<<<<< HEAD
                    color: Colors.white.withOpacity(0.9),

                    fontSize: 12,

                    fontWeight: FontWeight.w400,
=======
                    color:
                        Colors.white.withOpacity(0.9),

                    fontSize: 12,

                    fontWeight:
                        FontWeight.w400,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                  ),
                ),
              ],
            ),
          ),

          // ================= BOTTOM TEXT =================
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
          Positioned(
            left: 24,
            bottom: 28,

            child: Column(
<<<<<<< HEAD
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
=======
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Container(
                  padding:
                      const EdgeInsets.symmetric(
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                    horizontal: 12,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
<<<<<<< HEAD
                    color: Colors.green.withOpacity(0.20),

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(color: Colors.white.withOpacity(0.15)),
=======
                    color:
                        Colors.green.withOpacity(0.20),

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),

                    border: Border.all(
                      color:
                          Colors.white.withOpacity(0.15),
                    ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                  ),

                  child: const Text(
                    "DESA BONGKOK",

                    style: TextStyle(
                      color: Color(0xFFC8FFC8),
                      fontSize: 10,
<<<<<<< HEAD
                      fontWeight: FontWeight.w700,
=======
                      fontWeight:
                          FontWeight.w700,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
                    fontWeight: FontWeight.bold,
=======
                    fontWeight:
                        FontWeight.bold,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Portal digital warga desa",

                  style: TextStyle(
<<<<<<< HEAD
                    color: Colors.white.withOpacity(0.85),
=======
                    color:
                        Colors.white.withOpacity(0.85),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

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
<<<<<<< HEAD
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),

      child: Column(
        children: [
          // ================= TITLE =================
          Row(
            children: [
=======

    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        24,
        30,
        24,
        30,
      ),

      child: Column(
        children: [

          // ================= TITLE =================

          Row(
            children: [

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
              Container(
                width: 4,
                height: 18,

                decoration: BoxDecoration(
                  color: _primaryGreen,

<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(2),
=======
                  borderRadius:
                      BorderRadius.circular(
                    2,
                  ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                ),
              ),

              const SizedBox(width: 8),

              const Text(
                "MASUK KE AKUN ANDA",

                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.5,
<<<<<<< HEAD
                  fontWeight: FontWeight.w700,
=======
                  fontWeight:
                      FontWeight.w700,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                  color: _lightGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // EMAIL
<<<<<<< HEAD
          _buildFieldLabel("Email / No. HP"),
=======

          _buildFieldLabel(
            "Email / No. HP",
          ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

          const SizedBox(height: 8),

          _buildTextField(
<<<<<<< HEAD
            controller: _loginController.emailController,

            hint: "Masukkan email atau no. hp",

            icon: Icons.mail_outline_rounded,
=======
            controller:
                _loginController.emailController,

            hint:
                "Masukkan email atau no. hp",

            icon:
                Icons.mail_outline_rounded,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
          ),

          const SizedBox(height: 18),

          // PASSWORD
<<<<<<< HEAD
          _buildFieldLabel("Password"),
=======

          _buildFieldLabel(
            "Password",
          ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

          const SizedBox(height: 8),

          _buildTextField(
<<<<<<< HEAD
            controller: _loginController.passwordController,

            hint: "Masukkan password",

            icon: Icons.lock_outline_rounded,
=======
            controller:
                _loginController.passwordController,

            hint:
                "Masukkan password",

            icon:
                Icons.lock_outline_rounded,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

            isPassword: true,
          ),

          // FORGOT
<<<<<<< HEAD
          Align(
            alignment: Alignment.centerRight,
=======

          Align(
            alignment:
                Alignment.centerRight,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

            child: TextButton(
              onPressed: () {},

              child: const Text(
                "Lupa Password?",

<<<<<<< HEAD
                style: TextStyle(color: _primaryGreen),
=======
                style: TextStyle(
                  color: _primaryGreen,
                ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
              ),
            ),
          ),

          const SizedBox(height: 10),

          // LOGIN BUTTON
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
          _buildLoginButton(),

          const SizedBox(height: 24),

          // DIVIDER
<<<<<<< HEAD
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
=======

          Row(
            children: [

              Expanded(
                child: Divider(
                  color:
                      Colors.grey.shade300,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

                child: Text(
                  "atau",

<<<<<<< HEAD
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),

              Expanded(child: Divider(color: Colors.grey.shade300)),
=======
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ),

              Expanded(
                child: Divider(
                  color:
                      Colors.grey.shade300,
                ),
              ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
            ],
          ),

          const SizedBox(height: 20),

          // GOOGLE BUTTON
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
          _buildGoogleButton(),

          const SizedBox(height: 24),

          // REGISTER
<<<<<<< HEAD
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Belum punya akun?",

                style: TextStyle(color: Colors.grey.shade600),
=======

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Text(
                "Belum punya akun?",

                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
              ),

              const SizedBox(width: 5),

              GestureDetector(
                onTap: () {
<<<<<<< HEAD
                  Get.toNamed(Routes.REGISTER);
=======
                  Get.toNamed(
                    Routes.REGISTER,
                  );
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                },

                child: const Text(
                  "Daftar",

                  style: TextStyle(
<<<<<<< HEAD
                    color: _primaryGreen,

                    fontWeight: FontWeight.bold,
=======
                    color:
                        _primaryGreen,

                    fontWeight:
                        FontWeight.bold,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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

<<<<<<< HEAD
  Widget _buildFieldLabel(String text) {
=======
  Widget _buildFieldLabel(
    String text,
  ) {

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        text,

<<<<<<< HEAD
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
=======
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
      ),
    );
  }

  // =====================================================
  // TEXTFIELD
  // =====================================================

  Widget _buildTextField({
<<<<<<< HEAD
    required TextEditingController controller,
=======
    required TextEditingController
        controller,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

    required String hint,

    required IconData icon,

    bool isPassword = false,
  }) {
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    return Container(
      decoration: BoxDecoration(
        color: _bgColor,

<<<<<<< HEAD
        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: Colors.grey.shade200),
=======
        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
      ),

      child: TextField(
        controller: controller,

<<<<<<< HEAD
        obscureText: isPassword ? _obscurePassword : false,
=======
        obscureText:
            isPassword
                ? _obscurePassword
                : false,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

        decoration: InputDecoration(
          hintText: hint,

<<<<<<< HEAD
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),

          prefixIcon: Icon(icon, color: _lightGreen),
=======
          hintStyle: TextStyle(
            color:
                Colors.grey.shade500,
            fontSize: 13,
          ),

          prefixIcon: Icon(
            icon,
            color: _lightGreen,
          ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510

          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
<<<<<<< HEAD
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,

                    color: Colors.grey.shade500,
=======
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,

                    color:
                        Colors.grey.shade500,
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                  ),

                  onPressed: () {
                    setState(() {
<<<<<<< HEAD
                      _obscurePassword = !_obscurePassword;
=======
                      _obscurePassword =
                          !_obscurePassword;
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
                    });
                  },
                )
              : null,

          border: InputBorder.none,

<<<<<<< HEAD
          contentPadding: const EdgeInsets.symmetric(
=======
          contentPadding:
              const EdgeInsets.symmetric(
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
=======

>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    return SizedBox(
      width: double.infinity,
      height: 54,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
          backgroundColor: _primaryGreen,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
=======
          backgroundColor:
              _primaryGreen,

          elevation: 0,

          shape:
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
        ),

        onPressed: () {
          _loginController.login();
        },

<<<<<<< HEAD
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
=======
        child: Obx(() => _loginController.isLoading.value
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
              )),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
=======
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
<<<<<<< HEAD
          Image.asset("assets/images/google_logo.png", width: 22, height: 22),
=======
          Image.asset(
            "assets/images/google_logo.png",
            width: 22,
            height: 22,
          ),
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
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
<<<<<<< HEAD
}
=======
}
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
