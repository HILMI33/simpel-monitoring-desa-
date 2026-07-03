import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class AccountDetailsView extends GetView<ProfileController> {
  const AccountDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Akun Warga", style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF5F7FB),
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: controller.userPhotoUrl.value.isNotEmpty
                        ? NetworkImage(controller.userPhotoUrl.value)
                        : null,
                    child: controller.userPhotoUrl.value.isEmpty
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  )),
                ),
                const SizedBox(height: 32),
                _buildInfoRow("Nama Lengkap", controller.userName),
                const Divider(height: 32),
                _buildInfoRow("Alamat Email", controller.userEmail),
                const Divider(height: 32),
                _buildInfoRow("RT", controller.userRT),
                const Divider(height: 32),
                _buildInfoRow("RW", controller.userRW),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, RxString value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Obx(() => Text(
          value.value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
        )),
      ],
    );
  }
}
