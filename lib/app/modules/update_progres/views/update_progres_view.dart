import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/update_progres_controller.dart';

class UpdateProgresView extends GetView<UpdateProgresController> {
  const UpdateProgresView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Update Pembangunan", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final project = controller.project.value;
        if (project == null) {
          return const Center(child: Text("Data tidak ditemukan"));
        }

        final isStarted = project.startDate != null;
        final dateStr = isStarted ? DateFormat('dd MMM yyyy, HH:mm').format(project.startDate!) : "Belum dimulai";

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (project.progress == 100)
                    _buildUpdateItem(
                      date: project.endDate != null ? DateFormat('dd MMM yyyy, HH:mm').format(project.endDate!) : "Selesai",
                      title: "Pembangunan Selesai",
                      isFirst: true,
                      imageUrl: project.imageUrl,
                    ),
                  if (project.progress > 0 && project.progress < 100)
                    _buildUpdateItem(
                      date: "Sekarang",
                      title: "Pembangunan mencapai ${project.progress}%",
                      isFirst: true,
                      imageUrl: project.imageUrl,
                    ),
                  if (isStarted)
                    _buildUpdateItem(
                      date: dateStr,
                      title: "Proyek Dimulai",
                      isLast: project.progress == 0,
                    ),
                  if (!isStarted)
                    const Center(child: Text("Belum ada update pembangunan.")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() => ElevatedButton.icon(
                onPressed: controller.isLoading.value ? null : () => controller.toggleFollowProject(),
                icon: controller.isLoading.value
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Icon(controller.isFollowing.value ? Icons.check : Icons.add),
                label: Text(
                  controller.isFollowing.value ? "Mengikuti" : "Ikuti Update",
                  style: const TextStyle(fontSize: 16, color: Colors.white)
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: controller.isFollowing.value ? Colors.green : primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildUpdateItem({required String date, required String title, bool isFirst = false, bool isLast = false, String imageUrl = ''}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 4),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: imageUrl.isNotEmpty ? 180 : 80, // Approximate height to reach next dot
                color: Colors.blue.shade200,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                if (imageUrl.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
