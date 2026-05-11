import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
