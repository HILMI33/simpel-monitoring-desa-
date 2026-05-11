import 'package:get/get.dart';

class PengumumanController extends GetxController {
  final selectedCategory = "Semua".obs;
  final categories = ["Semua", "Informasi", "Agenda", "Bantuan"];

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}
