import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade50,
                    Colors.white,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                "Hai, ${controller.userName.value.split(' ').first}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A1A2E),
                                ),
                              )),
Obx(() => Text(
  "Hai, ${controller.userName.value.split(' ').first}",
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1A1A2E),
  ),
)),

const SizedBox(height: 8),
Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(6),
  ),
  child: Text(
    "Email Terverifikasi",
    style: TextStyle(
      color: Colors.green.shade700,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => controller.updateProfilePhoto(),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Obx(() => CircleAvatar(
                                    radius: 36,
                                    backgroundColor: Colors.grey.shade100,
                                    backgroundImage: controller.userPhotoUrl.value.isNotEmpty
                                        ? NetworkImage(controller.userPhotoUrl.value)
                                        : null,
                                    child: controller.userPhotoUrl.value.isEmpty
                                        ? const Icon(Icons.person, size: 40, color: Colors.grey)
                                        : null,
                                  )),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.edit, size: 12, color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Two Cards Row
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Get.toNamed('/account-details'),
                              child: _buildActionCard(
                                icon: Icons.star,
                                iconColor: Colors.blue.shade700,
                                title: "Akun Warga",
                                subtitle: "Lihat akun",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            
            // Menu Items
            const Divider(height: 1, thickness: 4, color: Color(0xFFF5F7FB)),
            
            _buildMenuItem(Icons.settings, "Pengaturan", onTap: () {
              Get.toNamed('/edit-profile');
            }),
            const Divider(height: 1, indent: 64),
            _buildMenuItem(Icons.history, "Riwayat Aktivitas", onTap: () {
              Get.toNamed('/activity-log');
            }),
            const Divider(height: 1, thickness: 4, color: Color(0xFFF5F7FB)),
            _buildMenuItem(Icons.language, "Bahasa", isLanguageToggle: true, onTap: () => controller.toggleLanguage()),
            
            const Divider(height: 1, thickness: 4, color: Color(0xFFF5F7FB)),
            
            _buildMenuItem(Icons.info_outline, "Tentang Aplikasi SIMPEL", onTap: () {
              controller.showInfoSheet("Tentang SIMPEL", "Sistem Informasi Manajemen Pelayanan Desa (SIMPEL) adalah platform digital yang membantu warga Desa Bongkok untuk melaporkan masalah infrastruktur, memantau pembangunan desa, dan mendapatkan layanan mandiri secara real-time.");
            }),
            const Divider(height: 1, indent: 64),
            _buildMenuItem(Icons.flag_outlined, "Syarat dan Ketentuan", onTap: () {
              controller.showInfoSheet("Syarat dan Ketentuan", "Dengan menggunakan aplikasi SIMPEL, Anda setuju untuk tidak menyalahgunakan platform untuk mengirim laporan palsu atau ujaran kebencian. Setiap laporan harus berdasarkan fakta yang dapat diverifikasi oleh admin desa.");
            }),
            const Divider(height: 1, indent: 64),
            _buildMenuItem(Icons.shield_outlined, "Kebijakan Privasi", onTap: () {
              controller.showInfoSheet("Kebijakan Privasi", "Data pribadi Anda, termasuk nama, email, dan NIK, dilindungi secara ketat. Kami hanya menggunakan data tersebut untuk keperluan verifikasi layanan administrasi tingkat desa dan tidak akan dibagikan ke pihak ketiga tanpa izin eksplisit dari Anda.");
            }),
            
            const Divider(height: 1, thickness: 4, color: Color(0xFFF5F7FB)),
            
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              leading: Icon(Icons.logout_rounded, color: Colors.red.shade700, size: 26),
              title: Text("Keluar", style: TextStyle(color: Colors.red.shade700, fontSize: 16)),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () => controller.logout(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required Color iconColor, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade800),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.blue.shade800, size: 16),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isLanguageToggle = false, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: Colors.indigo.shade400, size: 26),
      title: Text(title, style: const TextStyle(color: Color(0xFF1A1A2E), fontSize: 16)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLanguageToggle)
            Obx(() => Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("EN", style: TextStyle(
                      fontSize: 10, 
                      color: !controller.isIndonesian.value ? Colors.white : Colors.grey, 
                      fontWeight: FontWeight.bold
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: controller.isIndonesian.value ? Colors.blue.shade800 : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text("ID", style: TextStyle(
                      fontSize: 10, 
                      color: controller.isIndonesian.value ? Colors.white : Colors.grey, 
                      fontWeight: FontWeight.bold
                    )),
                  )
                ],
              ),
            )),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}
