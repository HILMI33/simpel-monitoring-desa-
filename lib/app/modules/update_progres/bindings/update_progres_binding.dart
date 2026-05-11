import 'package:get/get.dart';
import '../controllers/update_progres_controller.dart';

class UpdateProgresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProgresController>(
      () => UpdateProgresController(),
    );
  }
}
