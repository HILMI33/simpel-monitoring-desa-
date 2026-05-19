import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../history/views/history_view.dart';
import '../../pengumuman/views/pengumuman_view.dart';
import '../../profile/views/profile_view.dart';

class MainNavigationView extends GetView<MainNavigationController> {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            DashboardView(),
            HistoryView(),
            PengumumanView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changePage,
          backgroundColor: Colors.white,
          elevation: 10,
          indicatorColor: Theme.of(context).primaryColor.withOpacity(0.15),
          shadowColor: Colors.black.withOpacity(0.05),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Color(0xFF5B67F1)),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.description_outlined),
              selectedIcon: Icon(Icons.description, color: Color(0xFF5B67F1)),
              label: 'Laporan',
            ),
            NavigationDestination(
              icon: Icon(Icons.campaign_outlined),
              selectedIcon: Icon(Icons.campaign, color: Color(0xFF5B67F1)),
              label: 'Informasi',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Color(0xFF5B67F1)),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
