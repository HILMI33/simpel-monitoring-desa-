import 'package:get/get.dart';

class PembangunanController extends GetxController {
  final selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
