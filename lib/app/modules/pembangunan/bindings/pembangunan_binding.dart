import 'package:get/get.dart';
import '../controllers/pembangunan_controller.dart';

class PembangunanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembangunanController>(
      () => PembangunanController(),
    );
  }
}
