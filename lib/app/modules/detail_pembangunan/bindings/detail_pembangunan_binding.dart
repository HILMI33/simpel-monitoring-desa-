import 'package:get/get.dart';
import '../controllers/detail_pembangunan_controller.dart';

class DetailPembangunanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPembangunanController>(
      () => DetailPembangunanController(),
    );
  }
}
