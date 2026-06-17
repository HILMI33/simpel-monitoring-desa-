import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import '../controllers/peta_controller.dart';

class PetaView extends GetView<PetaController> {
  const PetaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Monitoring Desa', style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.markers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
            initialCenter: controller.currentLocation.value,
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.hilmi33.simpel',
            ),
            MarkerLayer(
              markers: controller.markers,
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5B67F1),
        onPressed: () => controller.getCurrentLocation(),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}