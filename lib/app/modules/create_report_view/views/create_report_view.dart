import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_report_view_controller.dart';

class CreateReportView extends GetView<CreateReportViewController> {
  const CreateReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Buat Laporan", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Kategori Laporan", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.transparent),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("Pilih Kategori", style: TextStyle(color: Colors.grey)),
                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
                    items: <String>['Infrastruktur', 'Kebersihan', 'Keamanan', 'Lainnya']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Tulis detail masalah...",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, right: 4),
                  child: Text("0/500", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 16),

              const Text("Lokasi (Otomatis)", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Dusun Krajan, Desa Sukamaju,\nKec. Sukamaju, Kab. Tegal",
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Icon(Icons.map_rounded, color: Colors.grey.shade500, size: 32),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text("Foto (Maks. 3 Foto)", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildPhotoPlaceholder(),
                  const SizedBox(width: 12),
                  _buildPhotoPlaceholder(),
                  const SizedBox(width: 12),
                  _buildAddButton(),
                ],
              ),
              const SizedBox(height: 24),

              const Text("Video (Opsional)", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E), fontSize: 15)),
              const SizedBox(height: 12),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(Icons.add_circle_outline_rounded, color: Colors.grey.shade400, size: 32),
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: const Color(0xFF5B67F1),
                  elevation: 4,
                  shadowColor: const Color(0xFF5B67F1).withValues(alpha: 0.4),
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
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 32),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.add_rounded, color: Colors.grey.shade500, size: 32),
    );
  }
}
