import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/dashboard_controller.dart';
import '../../../routes/app_routes.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/summary_card.dart';
import '../widgets/menu_grid.dart';
import '../widgets/announcement_card.dart';
import '../widgets/dashboard_shimmer.dart';
import '../../../../app/data/models/report_model.dart';
import '../../../../app/data/models/pengumuman_model.dart';

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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: DashboardShimmer(),
            );
          }
          return RefreshIndicator(
            onRefresh: controller.refreshData,
            color: _primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                const BannerCarousel(),
                const SizedBox(height: 24),
                const SummaryCard(),
                const SizedBox(height: 24),
                _buildSectionTitle('Menu Cepat'),
                const SizedBox(height: 12),
                const MenuGrid(),
                const SizedBox(height: 24),
                _buildSectionHeader(
                  'Laporan & Progres Terbaru',
                  onSeeAll: () => Get.toNamed(Routes.HISTORY),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => controller.recentReports.isEmpty
                      ? _buildEmptyState()
                      : Column(
                          children: controller.recentReports
                              .map((report) => _buildRecentReportItem(report))
                              .toList(),
                        ),
                ),
                const SizedBox(height: 24),
                _buildSectionHeader(
                  'Pengumuman',
                  onSeeAll: () => Get.toNamed(Routes.PENGUMUMAN),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => controller.recentAnnouncements.isEmpty
                      ? _buildEmptyAnnouncementState()
                      : Column(
                          children: controller.recentAnnouncements
                              .map(
                                (ann) => AnnouncementCard(
                                  icon: Icons.campaign_rounded,
                                  title: ann.title,
                                  subtitle: ann.content,
                                  imageUrl: ann.imageUrl,
                                  date: ann.createdAt != null
                                      ? DateFormat(
                                          'dd MMM yyyy',
                                        ).format(ann.createdAt!)
                                      : '-',
                                ),
                              )
                              .toList(),
                        ),
                ),
                const SizedBox(height: 80),
              ],
            ),
            ),
          );
        }),
      ),
    );
  }

  // ─── HEADER ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      children: [
        Obx(
          () => CircleAvatar(
            radius: 24,
            backgroundColor: _primary.withOpacity(0.15),
            backgroundImage: controller.userPhotoUrl.value.isNotEmpty
                ? NetworkImage(controller.userPhotoUrl.value)
                : null,
            child: controller.userPhotoUrl.value.isEmpty
                ? const Icon(Icons.person, color: _primary, size: 22)
                : null,
          ),
        ),
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
              Obx(
                () => Text(
                  'Halo, ${controller.userName.value}!',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            await Get.toNamed(Routes.NOTIFICATION);
            controller.refreshData(); // Refresh to update unread count
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded, size: 22),
                Obx(
                  () => controller.unreadNotificationCount.value > 0
                      ? Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              controller.unreadNotificationCount.value > 9
                                  ? '9+'
                                  : '${controller.unreadNotificationCount.value}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
        Expanded(child: _buildSectionTitle(title)),
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

  Widget _buildRecentReportItem(ReportModel report) {
    IconData categoryIcon = Icons.info_rounded;
    Color categoryColor = _primary;

    // Map Category to Icon
    if (report.category.contains('Infrastruktur')) {
      categoryIcon = Icons.construction_rounded;
      categoryColor = Colors.blue;
    } else if (report.category.contains('Kebersihan')) {
      categoryIcon = Icons.recycling_rounded;
      categoryColor = Colors.green;
    } else if (report.category.contains('Layanan')) {
      categoryIcon = Icons.account_balance_rounded;
      categoryColor = Colors.purple;
    } else if (report.category.contains('Keamanan')) {
      categoryIcon = Icons.local_police_rounded;
      categoryColor = Colors.indigo;
    } else if (report.category.contains('Darurat')) {
      categoryIcon = Icons.warning_amber_rounded;
      categoryColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Get.toNamed(Routes.DETAIL_REPORT, arguments: report),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(categoryIcon, size: 20, color: categoryColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report.category,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            report.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildSmallStatusBadge(report.status),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  report.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          report.createdAt != null
                              ? DateFormat(
                                  'dd MMM yyyy',
                                ).format(report.createdAt!)
                              : '-',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    if (report.adminNote.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 12,
                              color: Colors.blue.shade700,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Ada Respon",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallStatusBadge(String status) {
    Color color = Colors.grey;
    String label = status.toUpperCase();

    switch (status) {
      case 'pending':
        color = Colors.orange;
        label = "DITERIMA";
        break;
      case 'verified':
        color = Colors.blue;
        label = "DIVERIFIKASI";
        break;
      case 'on_progress':
        color = Colors.purple;
        label = "DIPROSES";
        break;
      case 'resolved':
        color = Colors.green;
        label = "SELESAI";
        break;
      case 'rejected':
        color = Colors.red;
        label = "DITOLAK";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Icon(
            Icons.assignment_late_outlined,
            size: 40,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            'Belum ada laporan terbaru',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyAnnouncementState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Icon(Icons.campaign_outlined, size: 40, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'Belum ada pengumuman terbaru',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
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
