import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:intl/intl.dart';

class ActivityLogView extends GetView<ProfileController> {
  const ActivityLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Riwayat Aktivitas", style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoadingLogs.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.myLogs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text("Belum ada aktivitas terekam.", style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myLogs.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final log = controller.myLogs[index];
            final dateFormat = DateFormat('dd MMM yyyy, HH:mm', 'id_ID');

            IconData icon;
            Color iconColor;
            String title;

            switch (log.action) {
              case 'LOGIN':
                icon = Icons.login;
                iconColor = Colors.blue;
                title = "Masuk ke Aplikasi";
                break;
              case 'UPDATE_PROFILE':
                icon = Icons.person;
                iconColor = Colors.orange;
                title = "Memperbarui Profil";
                break;
              case 'CREATE_REPORT':
                icon = Icons.report;
                iconColor = Colors.red;
                title = "Membuat Laporan Baru";
                break;
              case 'LIKE_REPORT':
                icon = Icons.thumb_up;
                iconColor = Colors.pink;
                title = "Menyukai Laporan";
                break;
              case 'COMMENT_REPORT':
                icon = Icons.comment;
                iconColor = Colors.purple;
                title = "Berkomentar di Laporan";
                break;
              default:
                icon = Icons.history;
                iconColor = Colors.grey;
                title = log.action;
            }

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              leading: CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor),
              ),
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  if (log.target.isNotEmpty)
                    Text(log.target, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(dateFormat.format(log.timestamp), style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
