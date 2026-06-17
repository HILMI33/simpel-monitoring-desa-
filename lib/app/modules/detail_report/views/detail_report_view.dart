import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/data/models/report_model.dart';
import '../controllers/detail_report_controller.dart';

class DetailReportView extends GetView<DetailReportController> {
  const DetailReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Rincian Laporan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        final r = controller.report.value;
        if (r == null) return const Center(child: CircularProgressIndicator());

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID Laporan #${r.id.length > 5 ? r.id.substring(0, 5).toUpperCase() : r.id.toUpperCase()}",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    _buildStatusBadge(r.status),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  r.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // -- FOTO SEBELUM & SESUDAH --
                const Text("Bukti Foto", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildImagePreview(r.imageUrl, "Sebelum"),
                    if (r.afterImageUrl.isNotEmpty) ...[
                      const SizedBox(width: 16),
                      _buildImagePreview(r.afterImageUrl, "Sesudah"),
                    ],
                  ],
                ),
                const SizedBox(height: 24),

                // -- DESKRIPSI & LOKASI --
                const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(r.description, style: TextStyle(color: Colors.grey.shade800)),
                const SizedBox(height: 20),

                // -- INTERAKSI WARGA (LIKE & KOMENTAR BAR) --
                Obx(() {
                  final liked = controller.isLiked.value;
                  final count = controller.likesCount.value;
                  final commCount = controller.comments.length;
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleLike(),
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: [
                              AnimatedScale(
                                scale: liked ? 1.2 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: liked ? Colors.red : Colors.grey.shade600,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "$count Suka",
                                style: TextStyle(
                                  color: liked ? Colors.red.shade700 : Colors.grey.shade700,
                                  fontWeight: liked ? FontWeight.bold : FontWeight.normal,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.grey.shade600,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$commCount Komentar",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),

                // -- ESTIMASI PENGERJAAN --
                if (r.status == 'on_progress' || r.status == 'resolved')
                  _buildEstimationSection(r),

                // -- ADMIN NOTE --
                if (r.adminNote.isNotEmpty) ...[
                  const Text("Catatan Admin", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Text(
                      r.adminNote,
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // -- TIMELINE --
                const Text("Riwayat Status & Progres", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator())
                else if (controller.statusLogs.isEmpty)
                  _buildTimelineItem(
                    title: "Laporan Diterima",
                    date: r.createdAt != null ? DateFormat('dd MMM yyyy, HH:mm').format(r.createdAt!) : "-",
                    note: "Laporan Anda telah terkirim dan sedang diproses oleh sistem.",
                    isDone: true,
                    isLast: true,
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.statusLogs.length,
                    itemBuilder: (context, index) {
                      final log = controller.statusLogs[index];
                      return _buildTimelineItem(
                        title: _getStatusTitle(log.status),
                        date: DateFormat('dd MMM yyyy, HH:mm').format(log.timestamp),
                        note: log.note,
                        isDone: true,
                        isLastDone: index == controller.statusLogs.length - 1,
                        isLast: index == controller.statusLogs.length - 1,
                      );
                    },
                  ),
                const SizedBox(height: 24),

                // -- DISKUSI WARGA (KOMENTAR) --
                const Divider(height: 1, color: Colors.black12),
                const SizedBox(height: 24),
                const Text("Diskusi Warga", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 12),
                Obx(() {
                  if (controller.comments.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded, size: 36, color: Colors.grey.shade300),
                          const SizedBox(height: 8),
                          Text(
                            "Belum ada komentar. Mulai diskusi!",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.comments.length,
                    itemBuilder: (context, index) {
                      final comment = controller.comments[index];
                      final formattedTime = DateFormat('dd MMM, HH:mm').format(comment.createdAt);
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FD),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF5B67F1).withOpacity(0.1),
                              backgroundImage: comment.userPhotoUrl.isNotEmpty 
                                  ? NetworkImage(comment.userPhotoUrl) 
                                  : null,
                              child: comment.userPhotoUrl.isEmpty
                                  ? Text(
                                      comment.userName.isNotEmpty ? comment.userName[0].toUpperCase() : 'W',
                                      style: const TextStyle(
                                        color: Color(0xFF5B67F1), 
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Color(0xFF1A1A2E),
                                        ),
                                      ),
                                      Text(
                                        formattedTime,
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    comment.content,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade800,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(height: 80), // Extra space to scroll above keyboard
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.report.value == null) return const SizedBox();
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 12,
            top: 12,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.commentController,
                  decoration: InputDecoration(
                    hintText: "Tulis komentar...",
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: const Color(0xFF5B67F1).withOpacity(0.5)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF5B67F1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  iconSize: 18,
                  onPressed: () => controller.sendComment(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = Colors.grey;
    String label = status.toUpperCase();

    switch (status) {
      case 'pending': color = Colors.orange; label = "DITERIMA"; break;
      case 'verified': color = Colors.blue; label = "DIVERIFIKASI"; break;
      case 'on_progress': color = Colors.purple; label = "DIPROSES"; break;
      case 'resolved': color = Colors.green; label = "SELESAI"; break;
      case 'rejected': color = Colors.red; label = "DITOLAK"; break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildImagePreview(String url, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: url.isNotEmpty
              ? Image.network(url, width: 120, height: 120, fit: BoxFit.cover)
              : Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildEstimationSection(ReportModel r) {
    if (r.estimatedStartDate == null && r.estimatedEndDate == null) return const SizedBox();
    
    final start = r.estimatedStartDate != null ? DateFormat('dd MMM').format(r.estimatedStartDate!) : '-';
    final end = r.estimatedEndDate != null ? DateFormat('dd MMM').format(r.estimatedEndDate!) : '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Estimasi Pengerjaan", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today_rounded, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              "$start s/d $end",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  String _getStatusTitle(String status) {
    switch (status) {
      case 'pending': return "Laporan Diterima";
      case 'verified': return "Diverifikasi Admin";
      case 'on_progress': return "Sedang Dikerjakan";
      case 'resolved': return "Selesai Dikerjakan";
      case 'rejected': return "Laporan Ditolak";
      default: return status;
    }
  }

  Widget _buildTimelineItem({
    required String title,
    required String date,
    required String note,
    required bool isDone,
    bool isLastDone = false,
    bool isLast = false,
    IconData icon = Icons.check_circle_outline,
  }) {
    final color = isDone ? const Color(0xFF5B67F1) : Colors.grey.shade300;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                  border: Border.all(
                    color: color,
                    width: isLastDone ? 4 : 2,
                  ),
                ),
                child: Icon(
                  isDone ? Icons.check : Icons.radio_button_unchecked,
                  size: 16,
                  color: color,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                    color: isDone ? const Color(0xFF1A1A2E) : Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                ),
                if (note.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        note,
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.4),
                      ),
                    ),
                  )
                else if (!isLast)
                  const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
