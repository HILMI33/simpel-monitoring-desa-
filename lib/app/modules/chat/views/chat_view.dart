import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Chat dengan Admin", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildChatBubble(
                  text: "Halo Andi, terima kasih atas laporan via Laporan Anda sedang kami verifikasi.",
                  time: "15 Mei 2024, 11:20",
                  isMe: false,
                ),
                _buildChatBubble(
                  text: "Baik, terima kasih 🙏",
                  time: "15 Mei 2024, 11:25",
                  isMe: true,
                ),
                _buildChatBubble(
                  text: "Kami butuh info lapangan lebih lanjut untuk penanganan lebih lanjut.",
                  time: "15 Mei 2024, 12:10",
                  isMe: false,
                ),
                _buildChatBubble(
                  text: "Siap, ditunggu informasinya selanjutnya.",
                  time: "15 Mei 2024, 12:14",
                  isMe: true,
                ),
              ],
            ),
          ),
          
          // Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: controller.messageController,
                        decoration: const InputDecoration(
                          hintText: "Tulis pesan...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 24,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({required String text, required String time, required bool isMe}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              radius: 16,
              child: const Icon(Icons.person, size: 20, color: Colors.blue),
            ),
            const SizedBox(width: 8),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 4),
                    child: Text("Admin Desa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue.shade700 : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 16),
                    ),
                    boxShadow: [
                      if (!isMe)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          
          if (isMe) const SizedBox(width: 24), // margin right for alignment
        ],
      ),
    );
  }
}
