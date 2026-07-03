import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart'; // Diperlukan untuk mendeteksi kIsWeb

class ApiService extends GetxService {
  // URL backend Railway yang baru
  final String baseUrl = 'https://vibrant-contentment-production-1625.up.railway.app/api';
  final GetStorage storage = GetStorage();

  Map<String, String> get _headers {
    final token = storage.read('token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    return await http.get(Uri.parse('$baseUrl$endpoint'), headers: _headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(data),
    );
  }

  Future<http.Response> patch(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    return await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(data),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(data),
    );
  }

  Future<String?> uploadImage(String filePath) async {
    final token = storage.read('token');
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload/'));

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(await http.MultipartFile.fromPath('image', filePath));

    var response = await request.send();
    if (response.statusCode == 201) {
      final resStr = await response.stream.bytesToString();
      final decoded = jsonDecode(resStr);
      return decoded['imageUrl'];
    }
    return null;
  }
}
