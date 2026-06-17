import 'package:get/get.dart';
import '../controllers/create_report_view_controller.dart';

class CreateReportViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateReportViewController>(() => CreateReportViewController());
  }
}
