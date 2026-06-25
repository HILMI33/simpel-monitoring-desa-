import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/detail_pembangunan_controller.dart';
import '../../../routes/app_routes.dart';

class DetailPembangunanView extends GetView<DetailPembangunanController> {
  const DetailPembangunanView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Pembangunan", style: TextStyle(color: Colors.black)),
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

        final period = project.startDate != null 
            ? "${DateFormat('dd MMM yyyy').format(project.startDate!)} - ${project.endDate != null ? DateFormat('dd MMM yyyy').format(project.endDate!) : 'Selesai'}"
            : "Tidak diketahui";

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Header
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      image: project.imageUrl.isNotEmpty
                          ? DecorationImage(image: NetworkImage(project.imageUrl), fit: BoxFit.cover)
                          : null,
                    ),
                    child: project.imageUrl.isEmpty 
                        ? const Icon(Icons.construction, size: 80, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: project.progress == 100 ? Colors.blue : Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        project.progress == 100 ? "Selesai" : "Sedang Berjalan",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Periode: $period",
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: project.progress / 100,
                              backgroundColor: Colors.grey.shade200,
                              color: Colors.blue,
                              minHeight: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text("${project.progress}%", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 30),
                    
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.UPDATE_PROGRES, arguments: project),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Lihat Semua Update", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
