import 'dart:convert';
import 'package:get/get.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/models/notification_model.dart';
import '../../../routes/app_routes.dart';

class NotificationController extends GetxController {
  final apiService = Get.find<ApiService>();

  final notifications = <NotificationModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final res = await apiService.get('/notifications/');
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        notifications.value = data.map((json) => NotificationModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(NotificationModel notification) async {
    if (notification.isRead) return;

    try {
      final res = await apiService.patch('/notifications/${notification.id}/read', {});
      if (res.statusCode == 200) {
        // Update locally
        final index = notifications.indexWhere((n) => n.id == notification.id);
        if (index != -1) {
          notifications[index] = NotificationModel(
            id: notification.id,
            title: notification.title,
            body: notification.body,
            data: notification.data,
            isRead: true,
            createdAt: notification.createdAt,
          );
          notifications.refresh();
        }
      }
    } catch (e) {
      print('Error marking as read: $e');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final res = await apiService.patch('/notifications/read-all', {});
      if (res.statusCode == 200) {
        for (var i = 0; i < notifications.length; i++) {
          notifications[i] = NotificationModel(
            id: notifications[i].id,
            title: notifications[i].title,
            body: notifications[i].body,
            data: notifications[i].data,
            isRead: true,
            createdAt: notifications[i].createdAt,
          );
        }
        notifications.refresh();
      }
    } catch (e) {
      print('Error marking all as read: $e');
    }
  }

  void onNotificationTap(NotificationModel notification) {
    markAsRead(notification);

    if (notification.data != null && notification.data!['type'] == 'project_update') {
      final projectId = notification.data!['project_id'];
      if (projectId != null) {
        // Navigate to project detail if you have the route, or just back to dashboard
        // Get.toNamed(Routes.DETAIL_PEMBANGUNAN, arguments: projectId);
      }
    }
  }
}
