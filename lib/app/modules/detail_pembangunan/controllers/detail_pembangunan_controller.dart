import 'package:get/get.dart';
import '../../../../app/data/models/pembangunan_model.dart';

class DetailPembangunanController extends GetxController {
  final project = Rxn<PembangunanModel>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is PembangunanModel) {
      project.value = Get.arguments as PembangunanModel;
    }
  }
}
