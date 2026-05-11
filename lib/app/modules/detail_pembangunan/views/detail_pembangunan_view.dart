import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Header
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.construction, size: 80, color: Colors.grey),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Sedang Berjalan",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
                  const Text(
                    "Perbaikan Jalan Desa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lokasi: Dusun Krajan",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Periode: 01 Mei - 30 Mei 2024",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.55,
                            backgroundColor: Colors.grey.shade200,
                            color: Colors.blue,
                            minHeight: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text("55%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    "Perbaikan jalan desa sepanjang 1,2 km untuk meningkatkan akses warga.",
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                  const SizedBox(height: 24),

                  const Text("Update Terbaru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  
                  _buildTimelineItem(
                    date: "15 Mei 2024, 09:30",
                    title: "Pengerasan jalan sepanjang 500m",
                  ),
                  _buildTimelineItem(
                    date: "10 Mei 2024, 10:15",
                    title: "Pembersihan area dan penggalian",
                    isLast: true,
                  ),

                  const SizedBox(height: 30),
                  
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.UPDATE_PROGRES),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Lihat Semua Update", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({required String date, required String title, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.blue,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}
