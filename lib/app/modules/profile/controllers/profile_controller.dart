import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../../app/data/services/firestore_service.dart';
import '../../../../app/data/models/user_model.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final authService = Get.find<AuthService>();
  final firestoreService = Get.find<FirestoreService>();
  
  final userName = 'Pengguna'.obs;
  final userPhone = '-'.obs;
  final userPhotoUrl = ''.obs;
  final userEmail = '-'.obs;
  final userRT = '-'.obs;
  final userRW = '-'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = authService.currentUser.value;
    if (user != null) {
      userName.value = user.name;
      userEmail.value = user.email;
      userPhotoUrl.value = user.photoUrl;
      // RT, RW etc from box if needed
      userRT.value = user.rt.isNotEmpty ? user.rt : '-';
      userRW.value = user.rw.isNotEmpty ? user.rw : '-';
    }
  }

  Future<void> logout() async {
    await authService.logout();
    box.write('isLoggedIn', false);
    box.erase(); // Clear storage on logout
    Get.offAllNamed(Routes.LOGIN);
  }
}

