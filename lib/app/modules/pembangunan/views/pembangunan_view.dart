import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/pembangunan_controller.dart';
import '../../../routes/app_routes.dart';

class PembangunanView extends GetView<PembangunanController> {
  const PembangunanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Pembangunan Desa", style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FB),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Obx(() => Row(
                children: [
                  _buildTabItem(0, "Sedang Berjalan"),
                  _buildTabItem(1, "Selesai"),
                ],
              )),
            ),
          ),
          
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredProjects.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.construction_outlined, size: 64, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text("Tidak ada proyek", style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = controller.filteredProjects[index];
                  return _buildProjectCard(
                    title: project.title,
                    location: "Lokasi Proyek", // Placeholder if no location name field
                    period: project.startDate != null 
                        ? "${DateFormat('dd MMM').format(project.startDate!)} - ${project.endDate != null ? DateFormat('dd MMM yyyy').format(project.endDate!) : 'Selesai'}"
                        : "-",
                    progress: project.progress / 100,
                    progressText: "${project.progress}%",
                    imageUrl: project.imageUrl,
                    onTap: () => Get.toNamed(Routes.DETAIL_PEMBANGUNAN, arguments: project),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: controller.selectedTab.value == index ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
            boxShadow: controller.selectedTab.value == index
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: controller.selectedTab.value == index ? const Color(0xFF5B67F1) : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String location,
    required String period,
    required double progress,
    required String progressText,
    required String imageUrl,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1A2E))),
                  const SizedBox(height: 4),
                  Text(location, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text("Periode: $period", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.shade100,
                            color: const Color(0xFF5B67F1),
                            minHeight: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(progressText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF5B67F1))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                image: imageUrl.isNotEmpty ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover) : null,
              ),
              child: imageUrl.isEmpty ? Icon(Icons.construction_rounded, color: Colors.grey.shade400, size: 32) : null,
            ),
          ],
        ),
      ),
    );
  }
}
