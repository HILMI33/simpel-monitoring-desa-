import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../app/data/services/api_service.dart';
import '../../../../app/data/models/report_model.dart';

class HistoryController extends GetxController {
  final apiService = Get.find<ApiService>();
  
  final selectedFilter = "Semua".obs;
  final filters = ["Semua", "Pending", "Diproses", "Selesai", "Ditolak"];

  // Scopes for community interaction
  final selectedScope = "Semua Laporan".obs;
  final scopes = ["Semua Laporan", "Laporan Saya"];

  final reports = <ReportModel>[].obs;
  final filteredReports = <ReportModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;
      final scopeParam = selectedScope.value == "Laporan Saya" ? "my" : "all";
      final response = await apiService.get('/reports/?scope=$scopeParam');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<ReportModel> list = data.map((json) => ReportModel.fromJson(json)).toList();
        reports.assignAll(list);
        applyFilter();
      }
    } catch (e) {
      debugPrint('Error fetching history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void changeScope(String scope) {
    selectedScope.value = scope;
    fetchReports();
  }

  void applyFilter() {
    if (selectedFilter.value == "Semua") {
      filteredReports.assignAll(reports);
    } else {
      String status = selectedFilter.value.toLowerCase();
      // Map UI filter to DB status
      if (status == "diproses") status = "on_progress";
      if (status == "selesai") status = "resolved";
      if (status == "ditolak") status = "rejected";
      
      filteredReports.assignAll(reports.where((r) => r.status == status).toList());
    }
  }
}
