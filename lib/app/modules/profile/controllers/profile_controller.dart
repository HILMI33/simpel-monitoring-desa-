import 'package:get/get.dart';

class ProfileController extends GetxController {
  void logout() {
    // Perform logout logic
    Get.offAllNamed('/login');
  }
}
