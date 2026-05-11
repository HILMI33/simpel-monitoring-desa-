import 'package:get/get.dart';

class HistoryController extends GetxController {
  final selectedFilter = "Semua".obs;
  final filters = ["Semua", "Dikirim", "Selesai", "Ditolak"];

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }
}
