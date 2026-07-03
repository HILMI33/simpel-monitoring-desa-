import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/models/chat_message_model.dart';

class ChatController extends GetxController {
  final apiService = Get.find<ApiService>();
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  
  final messages = <ChatMessageModel>[].obs;
  final isLoading = true.obs;
  final isSending = false.obs;
  Timer? _pollingTimer;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
    _startPolling();
  }

  @override
  void onClose() {
    _pollingTimer?.cancel();
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isSending.value) {
        fetchMessages(isPolling: true);
      }
    });
  }

  Future<void> fetchMessages({bool isPolling = false}) async {
    if (!isPolling) isLoading.value = true;
    try {
      final response = await apiService.get('/chat/my-messages');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final newMessages = data.map((e) => ChatMessageModel.fromJson(e)).toList();
        
        // If the number of messages changed, we might want to scroll to bottom
        bool shouldScroll = messages.length != newMessages.length;
        messages.assignAll(newMessages);
        
        if (shouldScroll && messages.isNotEmpty) {
          _scrollToBottom();
        }
      }
    } catch (e) {
      debugPrint('Error fetching chat messages: $e');
    } finally {
      if (!isPolling) isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    isSending.value = true;
    messageController.clear();
    
    // Optimistic UI update (optional, but good for UX)
    messages.add(ChatMessageModel(
      id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me',
      senderRole: 'warga',
      message: text,
      createdAt: DateTime.now(),
    ));
    _scrollToBottom();

    try {
      final response = await apiService.post('/chat/my-messages', {
        'message': text,
      });
      
      if (response.statusCode == 201) {
        // Fetch to get actual ID and exact timestamp
        await fetchMessages(isPolling: true);
      } else {
        Get.snackbar('Error', 'Gagal mengirim pesan');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan jaringan');
    } finally {
      isSending.value = false;
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100, // +100 to ensure it goes all the way
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
