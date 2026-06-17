import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/history_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../../app/data/models/report_model.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Aktivitas Laporan", style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Scope Selector (Semua Laporan vs Laporan Saya)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: controller.scopes.map((scope) {
                  return Expanded(
                    child: Obx(() {
                      final isSelected = controller.selectedScope.value == scope;
                      return GestureDetector(
                        onTap: () => controller.changeScope(scope),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ] : [],
                          ),
                          child: Center(
                            child: Text(
                              scope,
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF5B67F1) : Colors.grey.shade600,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.filters.length,
                itemBuilder: (context, index) {
                  final filter = controller.filters[index];
                  return Obx(() {
                    final isSelected = controller.selectedFilter.value == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => controller.changeFilter(filter),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF5B67F1) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? const Color(0xFF5B67F1) : Colors.grey.shade300),
                            boxShadow: isSelected ? [
                              BoxShadow(color: const Color(0xFF5B67F1).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))
                            ] : [],
                          ),
                          child: Center(
                            child: Text(
                              filter,
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
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.filteredReports.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_outlined, size: 64, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text("Belum ada laporan", style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredReports.length,
                itemBuilder: (context, index) {
                  final report = controller.filteredReports[index];
                  return _buildHistoryCard(
                    report: report,
                    onTap: () => Get.toNamed(Routes.DETAIL_REPORT, arguments: report),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required ReportModel report,
    VoidCallback? onTap,
  }) {
    Color statusColor;
    String statusLabel;

    switch (report.status.toLowerCase()) {
      case 'pending': statusColor = Colors.orange; statusLabel = "Diterima"; break;
      case 'verified': statusColor = Colors.blue; statusLabel = "Terverifikasi"; break;
      case 'on_progress': statusColor = Colors.purple; statusLabel = "Diproses"; break;
      case 'resolved': statusColor = Colors.green; statusLabel = "Selesai"; break;
      case 'rejected': statusColor = Colors.red; statusLabel = "Ditolak"; break;
      default: statusColor = Colors.grey; statusLabel = report.status;
    }

    IconData categoryIcon = Icons.info_rounded;
    Color categoryColor = const Color(0xFF5B67F1);

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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(categoryIcon, color: categoryColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        report.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        report.createdAt != null 
                            ? DateFormat('dd MMM yyyy').format(report.createdAt!)
                            : '-',
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    report.title, 
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 16, 
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    report.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          statusLabel.toUpperCase(),
                          style: TextStyle(
                            color: statusColor, 
                            fontSize: 9, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey),
                    ],
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
