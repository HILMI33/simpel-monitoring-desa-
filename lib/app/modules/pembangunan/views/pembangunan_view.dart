import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pembangunan_controller.dart';
import '../../../routes/app_routes.dart';

class PembangunanView extends GetView<PembangunanController> {
  const PembangunanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Pembangunan Desa", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: controller.selectedTab.value == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: controller.selectedTab.value == 0
                              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Sedang Berjalan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.selectedTab.value == 0 ? const Color(0xFF5B67F1) : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: controller.selectedTab.value == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: controller.selectedTab.value == 1
                              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Selesai",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.selectedTab.value == 1 ? const Color(0xFF5B67F1) : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildProjectCard(
                  title: "Perbaikan Jalan Desa",
                  location: "Dusun Krajan",
                  period: "01 Mei - 30 Mei 2024",
                  progress: 0.55,
                  progressText: "55%",
                ),
                _buildProjectCard(
                  title: "Pembangunan Drainase",
                  location: "Dusun Wetan",
                  period: "01 Mei - 15 Juni 2024",
                  progress: 0.80,
                  progressText: "80%",
                ),
                _buildProjectCard(
                  title: "Pembangunan Posyandu",
                  location: "Dusun Krajan",
                  period: "01 Mei - 31 Jul 2024",
                  progress: 0.30,
                  progressText: "30%",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String location,
    required String period,
    required double progress,
    required String progressText,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_PEMBANGUNAN),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
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
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                            backgroundColor: Colors.grey.shade200,
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
              ),
              child: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
