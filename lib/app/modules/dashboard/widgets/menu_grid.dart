import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
            colors: [menu.color.withOpacity(0.7), menu.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: menu.color.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                menu.icon,
                size: 80,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
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
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const _MenuItem(this.title, this.icon, this.color, this.route);
}
