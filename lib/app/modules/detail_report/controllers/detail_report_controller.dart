import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/services/auth_service.dart';
import '../../../../app/data/models/report_model.dart';
import '../../../../app/data/models/status_log_model.dart';
import '../../../../app/data/models/comment_model.dart';

class DetailReportController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final AuthService _auth = Get.find<AuthService>();

  final report = Rxn<ReportModel>();
  final statusLogs = <StatusLogModel>[].obs;
  final isLoading = false.obs;

  // Interactions State
  final isLiked = false.obs;
  final likesCount = 0.obs;
  final comments = <CommentModel>[].obs;

  final commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      report.value = Get.arguments as ReportModel;
      statusLogs.value = report.value!.logs;
      
      // Load initial state from the passed argument
      likesCount.value = report.value!.likes.length;
      comments.value = report.value!.comments;
      _checkIfLiked();

      // Fetch fresh details from API
      fetchReportDetail();
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }

  void _checkIfLiked() {
    final user = _auth.currentUser.value;
    if (user != null && report.value != null) {
      isLiked.value = report.value!.likes.contains(user.id);
    }
  }

  Future<void> fetchReportDetail() async {
    if (report.value == null) return;
    try {
      isLoading.value = true;
      final response = await _api.get('/reports/${report.value!.id}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final freshReport = ReportModel.fromJson(data);
        report.value = freshReport;
        statusLogs.value = freshReport.logs;
        likesCount.value = freshReport.likes.length;
        comments.value = freshReport.comments;
        _checkIfLiked();
      }
    } catch (e) {
      debugPrint('Error fetching report details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleLike() async {
    if (report.value == null) return;
    final user = _auth.currentUser.value;
    if (user == null) {
      Get.snackbar('Perhatian', 'Anda harus masuk terlebih dahulu');
      return;
    }

    // Optimistic UI update
    if (isLiked.value) {
      isLiked.value = false;
      likesCount.value--;
    } else {
      isLiked.value = true;
      likesCount.value++;
    }

    try {
      final response = await _api.post('/reports/${report.value!.id}/like', {});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        isLiked.value = data['is_liked'] ?? false;
        likesCount.value = data['likes_count'] ?? 0;
        
        // Update local report object likes
        final List<dynamic> likesList = data['likes'] ?? [];
        final updatedLikes = likesList.map((l) => l.toString()).toList();
        report.value = ReportModel(
          id: report.value!.id,
          userId: report.value!.userId,
          userName: report.value!.userName,
          title: report.value!.title,
          description: report.value!.description,
          category: report.value!.category,
          imageUrl: report.value!.imageUrl,
          latitude: report.value!.latitude,
          longitude: report.value!.longitude,
          status: report.value!.status,
          createdAt: report.value!.createdAt,
          updatedAt: report.value!.updatedAt,
          adminNote: report.value!.adminNote,
          afterImageUrl: report.value!.afterImageUrl,
          rating: report.value!.rating,
          logs: report.value!.logs,
          likes: updatedLikes,
          comments: report.value!.comments,
        );
      } else {
        // Rollback optimistic update on failure
        fetchReportDetail();
      }
    } catch (e) {
      debugPrint('Error toggling like: $e');
      fetchReportDetail(); // Rollback
    }
  }

  Future<void> sendComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    if (report.value == null) return;
    final user = _auth.currentUser.value;
    if (user == null) {
      Get.snackbar('Perhatian', 'Anda harus masuk terlebih dahulu');
      return;
    }

    commentController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final response = await _api.post('/reports/${report.value!.id}/comments', {'content': text});
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final newComment = CommentModel.fromJson(data['comment']);
        comments.add(newComment);
        
        Get.snackbar('Sukses', 'Komentar berhasil dikirim');
      } else {
        Get.snackbar('Gagal', 'Gagal mengirim komentar');
      }
    } catch (e) {
      debugPrint('Error sending comment: $e');
      Get.snackbar('Error', 'Koneksi gagal');
    }
  }
}
