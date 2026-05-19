import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/create_report_view/bindings/create_report_view_binding.dart';
import '../modules/create_report_view/views/create_report_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_pembangunan/bindings/detail_pembangunan_binding.dart';
import '../modules/detail_pembangunan/views/detail_pembangunan_view.dart';
import '../modules/detail_report/bindings/detail_report_binding.dart';
import '../modules/detail_report/views/detail_report_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/pembangunan/bindings/pembangunan_binding.dart';
import '../modules/pembangunan/views/pembangunan_view.dart';
import '../modules/pengumuman/bindings/pengumuman_binding.dart';
import '../modules/pengumuman/views/pengumuman_view.dart';
import '../modules/peta/bindings/peta_binding.dart';
import '../modules/peta/views/peta_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/update_progres/bindings/update_progres_binding.dart';
import '../modules/update_progres/views/update_progres_view.dart';
import '../modules/security_verification/bindings/security_verification_binding.dart';
import '../modules/security_verification/views/security_verification_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.MAIN_NAVIGATION,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.CREATE_REPORT,
      page: () => const CreateReportView(),
      binding: CreateReportViewBinding(),
    ),
    GetPage(
      name: Routes.PETA,
      page: () => const PetaView(),
      binding: PetaBinding(),
    ),
    GetPage(
      name: Routes.PEMBANGUNAN,
      page: () => const PembangunanView(),
      binding: PembangunanBinding(),
    ),
    GetPage(
      name: Routes.PENGUMUMAN,
      page: () => const PengumumanView(),
      binding: PengumumanBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PROGRES,
      page: () => const UpdateProgresView(),
      binding: UpdateProgresBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_REPORT,
      page: () => const DetailReportView(),
      binding: DetailReportBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PEMBANGUNAN,
      page: () => const DetailPembangunanView(),
      binding: DetailPembangunanBinding(),
    ),
    GetPage(
      name: Routes.SECURITY_VERIFICATION,
      page: () => const SecurityVerificationView(),
      binding: SecurityVerificationBinding(),
    ),
  ];
}