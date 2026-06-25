import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/create_report_view_controller.dart';

class CreateReportView extends GetView<CreateReportViewController> {
  const CreateReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Lapor Masalah", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Apa yang ingin Anda laporkan?", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 16)),
                  const SizedBox(height: 16),

                  const Text("Kategori Utama", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Obx(() => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.selectedCategory.value,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
                        items: [
                          _buildCategoryItem('Infrastruktur Desa', Icons.construction_rounded, Colors.blue),
                          _buildCategoryItem('Kebersihan Lingkungan', Icons.recycling_rounded, Colors.green),
                          _buildCategoryItem('Layanan Publik', Icons.account_balance_rounded, Colors.purple),
                          _buildCategoryItem('Keamanan & Ketertiban', Icons.local_police_rounded, Colors.indigo),
                          _buildCategoryItem('Darurat & Bencana', Icons.warning_amber_rounded, Colors.red),
                          _buildCategoryItem('Lainnya', Icons.more_horiz_rounded, Colors.grey),
                        ],
                        onChanged: controller.onCategoryChanged,
                      ),
                    )),
                  ),
                  const SizedBox(height: 24),

                  const Text("Jenis Masalah", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Obx(() => DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.selectedSubCategory.value,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
                        items: (controller.subCategories[controller.selectedCategory.value] ?? [])
                            .map((sub) => DropdownMenuItem(
                                  value: sub,
                                  child: Text(sub, style: const TextStyle(fontSize: 14)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) controller.selectedSubCategory.value = val;
                        },
                      ),
                    )),
                  ),
                  const SizedBox(height: 24),

                  const Text("Detail / Rincian", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: controller.descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Tuliskan rincian laporan Anda di sini...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text("Lokasi Laporan", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _showMapPicker(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Obx(() => Text(
                                controller.address.value,
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5),
                              )),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5B67F1).withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: const Icon(Icons.map_rounded, color: Color(0xFF5B67F1), size: 32),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text("Foto Pendukung (Maks 3)", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
                  const SizedBox(height: 12),
                  Obx(() => Row(
                    children: [
                      ...controller.selectedImages.asMap().entries.map((entry) {
                        int index = entry.key;
                        File file = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  file,
                                  width: 84,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => controller.removeImage(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, color: Colors.white, size: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      if (controller.selectedImages.length < 3)
                        _buildAddButton(() {
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Kamera'),
                                    onTap: () {
                                      Get.back();
                                      controller.pickImage(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Galeri'),
                                    onTap: () {
                                      Get.back();
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    ],
                  )),
                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () => controller.submitReport(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      backgroundColor: const Color(0xFF5B67F1),
                      elevation: 4,
                      shadowColor: const Color(0xFF5B67F1).withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Kirim Laporan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => controller.isLoading.value 
            ? Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator(color: Colors.white)),
              )
            : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.add_rounded, color: Colors.grey.shade500, size: 32),
      ),
    );
  }

  DropdownMenuItem<String> _buildCategoryItem(String value, IconData icon, Color color) {
    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _showMapPicker(BuildContext context) {
    LatLng selectedLocation = LatLng(controller.latitude.value, controller.longitude.value);
    final mapController = MapController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 450,
            width: double.infinity,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: selectedLocation,
                    initialZoom: 15,
                    onPositionChanged: (position, hasGesture) {
                      if (position.center != null) {
                        selectedLocation = position.center!;
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.hilmi33.simpel',
                    ),
                  ],
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateLocation(selectedLocation.latitude, selectedLocation.longitude);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B67F1),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Pilih Lokasi Ini", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
