import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_report_controller.dart';

class DetailReportView extends GetView<DetailReportController> {
  const DetailReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Laporan", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ID Laporan #1024", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("Diproses", style: TextStyle(color: Colors.yellow.shade800, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              const Text(
                "Jalan Rusak di Depan Balai Desa",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "Jalan Balai Desa, Dusun Krajan",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "15 Mei 2024, 10:30",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),
              const SizedBox(height: 20),

              const Text("Lokasi", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Icon(Icons.map, size: 40, color: Colors.grey)),
              ),
              const SizedBox(height: 20),

              const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                "Terdapat lubang besar di jalan depan balai desa sehingga membahayakan pengguna jalan.",
                style: TextStyle(color: Colors.grey.shade800),
              ),
              const SizedBox(height: 20),

              const Text("Foto", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildPhotoItem(),
                  const SizedBox(width: 8),
                  _buildPhotoItem(),
                  const SizedBox(width: 8),
                  _buildPhotoItem(),
                ],
              ),
              const SizedBox(height: 24),

              const Text("Status Laporan", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              _buildTimelineItem(title: "Laporan Diterima", date: "15 Mei 2024, 10:30", isDone: true),
              _buildTimelineItem(title: "Verifikasi oleh Admin", date: "15 Mei 2024, 11:15", isDone: true),
              _buildTimelineItem(title: "Sedang Diproses", date: "15 Mei 2024, 13:00", isDone: true, isLastDone: true),
              _buildTimelineItem(title: "Selesai", date: "", isDone: false, isLast: true),

              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Chat Admin", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoItem() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  Widget _buildTimelineItem({required String title, required String date, required bool isDone, bool isLastDone = false, bool isLast = false}) {
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
                color: isDone ? Colors.blue : Colors.grey.shade300,
                border: Border.all(
                  color: isLastDone ? Colors.blue.shade200 : Colors.transparent,
                  width: isLastDone ? 4 : 0,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isDone && !isLastDone ? Colors.blue : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                color: isDone ? Colors.black : Colors.grey,
              ),
            ),
            if (date.isNotEmpty)
              Text(
                date,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
          ],
        ),
      ],
    );
  }
}
