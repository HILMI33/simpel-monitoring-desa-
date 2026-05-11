import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../history/controllers/history_controller.dart';
import '../../pengumuman/controllers/pengumuman_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(
      () => MainNavigationController(),
    );
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);
    Get.lazyPut<PengumumanController>(() => PengumumanController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
