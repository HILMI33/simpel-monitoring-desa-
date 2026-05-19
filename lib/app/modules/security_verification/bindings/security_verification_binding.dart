import 'package:get/get.dart';
import '../controllers/security_verification_controller.dart';

class SecurityVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecurityVerificationController>(
      () => SecurityVerificationController(),
    );
  }
}
