import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pengumuman_controller.dart';

class PengumumanView extends GetView<PengumumanController> {
  const PengumumanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Pengumuman", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: Navigator.canPop(context) 
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back())
            : null,
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Obx(() {
                    final isSelected = controller.selectedCategory.value == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => controller.changeCategory(category),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF5B67F1) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? const Color(0xFF5B67F1) : Colors.grey.shade300),
                            boxShadow: isSelected ? [
                              BoxShadow(color: const Color(0xFF5B67F1).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))
                            ] : [],
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey.shade700,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.black12),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildAnnouncementCard(
                  title: "Kerja Bakti Desa",
                  date: "Minggu, 18 Mei 2024 pukul 07:00 WIB\ndi Balai Desa",
                  timeAgo: "15 Mei 2024",
                  tag: "PENTING",
                  tagColor: Colors.red,
                  icon: Icons.cleaning_services,
                ),
                _buildAnnouncementCard(
                  title: "Posyandu Balita",
                  date: "Dilaksanakan pada hari Jumat, 20 Mei 2024 di Balai Desa",
                  timeAgo: "16 Mei 2024",
                  tag: "INFO",
                  tagColor: Colors.blue,
                  icon: Icons.child_care,
                ),
                _buildAnnouncementCard(
                  title: "Bantuan Pangan Tahap 1",
                  date: "Pelayanan pada tanggal 22 Mei 2024\nHarap membawa KTP",
                  timeAgo: "18 Mei 2024",
                  tag: "SYARAT BANTUAN",
                  tagColor: Colors.orange,
                  icon: Icons.food_bank,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard({
    required String title,
    required String date,
    required String timeAgo,
    required String tag,
    required Color tagColor,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [tagColor.withValues(alpha: 0.2), tagColor.withValues(alpha: 0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: tagColor.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: tagColor, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        tag, 
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.history, size: 12, color: Colors.grey.shade400),
                        const SizedBox(width: 4),
                        Text(timeAgo, style: TextStyle(color: Colors.grey.shade400, fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1A2E), height: 1.2)
                ),
                const SizedBox(height: 6),
                Text(
                  date, 
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
