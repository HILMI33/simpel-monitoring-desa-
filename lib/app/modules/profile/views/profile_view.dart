import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Profil", style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF5F7FB),
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        centerTitle: true,
        leading: Navigator.canPop(context) 
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back())
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF5B67F1).withValues(alpha: 0.3), width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: const Color(0xFF5B67F1).withValues(alpha: 0.1),
                        child: const Icon(Icons.person_rounded, size: 46, color: Color(0xFF5B67F1)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Andi Saputra",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "0812 3456 7890",
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Menu Group 1
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.person_outline_rounded, "Ubah Profil"),
                    const Divider(height: 1, indent: 60),
                    _buildMenuItem(Icons.lock_outline_rounded, "Ubah Password"),
                    const Divider(height: 1, indent: 60),
                    _buildMenuItem(Icons.notifications_none_rounded, "Notifikasi"),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Menu Group 2
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.info_outline_rounded, "Tentang Aplikasi"),
                    const Divider(height: 1, indent: 60),
                    _buildMenuItem(Icons.privacy_tip_outlined, "Kebijakan Privasi"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Logout Button
              GestureDetector(
                onTap: () => controller.logout(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red.shade600, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        "Keluar",
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF5B67F1).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF5B67F1), size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A1A2E),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, size: 24, color: Colors.grey.shade400),
      onTap: () {},
    );
  }
}
