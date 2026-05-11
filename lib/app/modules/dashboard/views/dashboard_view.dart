import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';
import '../../../routes/app_routes.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  static const _primary = Color(0xFF5B67F1);
  static const _bg = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _primary,
        elevation: 3,
        onPressed: () => Get.toNamed(Routes.CREATE_REPORT),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildBannerCarousel(),
              const SizedBox(height: 24),
              _buildSummaryCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Menu Cepat'),
              const SizedBox(height: 12),
              _buildMenuGrid(),
              const SizedBox(height: 24),
              _buildSectionHeader('Pengumuman', onSeeAll: () => Get.toNamed(Routes.PENGUMUMAN)),
              const SizedBox(height: 12),
              _buildAnnouncementCard(
                icon: Icons.groups_rounded,
                title: 'Kerja Bakti Desa',
                subtitle: 'Minggu, 18 Mei 2024 pukul 07:00 WIB',
                date: '15 Mei 2024',
                isNew: true,
              ),
              _buildAnnouncementCard(
                icon: Icons.campaign_rounded,
                title: 'Musyawarah Desa',
                subtitle: 'Senin, 20 Mei 2024 pukul 19:00 WIB',
                date: '14 Mei 2024',
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  // ─── HEADER ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        Obx(() => CircleAvatar(
              radius: 24,
              backgroundColor: _primary.withValues(alpha: 0.15),
              backgroundImage: controller.userPhotoUrl.value.isNotEmpty
                  ? NetworkImage(controller.userPhotoUrl.value)
                  : null,
              child: controller.userPhotoUrl.value.isEmpty
                  ? const Icon(Icons.person, color: _primary, size: 22)
                  : null,
            )),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang kembali 👋',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 2),
              Obx(() => Text(
                    'Halo, ${controller.userName.value}!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  )),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.notifications_none_rounded, size: 22),
        ),
      ],
    );
  }

  // ─── BANNER CAROUSEL ───────────────────────────────────────────────────────

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            itemCount: controller.banners.length,
            onPageChanged: (index) => controller.currentBannerIndex.value = index,
            itemBuilder: (context, index) {
              final banner = controller.banners[index];
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: banner['color'] as Color,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: (banner['color'] as Color).withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'PENGUMUMAN PENTING',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            banner['title'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner['subtitle'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      banner['icon'] as IconData,
                      size: 60,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.banners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: controller.currentBannerIndex.value == index ? 24 : 6,
                  decoration: BoxDecoration(
                    color: controller.currentBannerIndex.value == index
                        ? _primary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  // ─── SUMMARY CARD ──────────────────────────────────────────────────────────

  Widget _buildSummaryCard() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5B67F1), Color(0xFF7B87FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat(controller.totalLaporan.value.toString(), 'Total'),
              _buildVerticalDivider(),
              _buildStat(controller.laporanDiproses.value.toString(), 'Diproses'),
              _buildVerticalDivider(),
              _buildStat(controller.laporanSelesai.value.toString(), 'Selesai'),
            ],
          ),
        ));
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 44, color: Colors.white24);
  }

  // ─── SECTION TITLE ─────────────────────────────────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A1A2E),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionTitle(title),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'Lihat Semua',
              style: TextStyle(
                color: _primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  // ─── MENU GRID ─────────────────────────────────────────────────────────────

  Widget _buildMenuGrid() {
    const menus = [
      _MenuItem('Laporan', Icons.edit_document, Color(0xFF5B67F1), Routes.CREATE_REPORT),
      _MenuItem('Peta', Icons.map_rounded, Color(0xFF4B5EAA), Routes.PETA),
      _MenuItem('Bangun', Icons.home_repair_service, Color(0xFFFF9800), Routes.PEMBANGUNAN),
      _MenuItem('Info', Icons.campaign_rounded, Color(0xFFE91E8C), Routes.PENGUMUMAN),
      _MenuItem('Chat', Icons.chat_bubble_rounded, Color(0xFF009688), Routes.CHAT),
      _MenuItem('Riwayat', Icons.history_rounded, Color(0xFF4CAF50), Routes.HISTORY),
    ];

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: menus.map((m) => _buildMenuItem(m)).toList(),
    );
  }

  Widget _buildMenuItem(_MenuItem menu) {
    return GestureDetector(
      onTap: () => Get.toNamed(menu.route),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [menu.color.withValues(alpha: 0.7), menu.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: menu.color.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative background icon
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                menu.icon,
                size: 80,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            // Foreground content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(menu.icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menu.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── ANNOUNCEMENT CARD ─────────────────────────────────────────────────────

  Widget _buildAnnouncementCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: _primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Baru',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── DATA MODEL ────────────────────────────────────────────────────────────────

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const _MenuItem(this.title, this.icon, this.color, this.route);
}