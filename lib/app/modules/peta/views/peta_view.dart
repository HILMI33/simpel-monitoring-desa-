import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/peta_controller.dart';

class PetaView extends GetView<PetaController> {
  const PetaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Monitoring'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
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
              userAgentPackageName: 'com.example.simpel', // Sesuaikan package name Anda
            ),
            MarkerLayer(
              markers: [
                // Marker lokasi user
                Marker(
                  point: controller.currentLocation.value,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
                // Nanti tambahkan: ...controller.reportMarkers,
                // Nanti tambahkan: ...controller.pembangunanMarkers,
              ],
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getCurrentLocation();
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}