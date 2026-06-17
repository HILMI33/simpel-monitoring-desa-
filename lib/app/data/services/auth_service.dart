import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService extends GetxService {
  final ApiService _api = Get.find<ApiService>();
  final GetStorage _storage = GetStorage();
  
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final userData = _storage.read('user');
    final token = _storage.read('token');
    if (token != null && userData != null) {
      currentUser.value = UserModel.fromJson(userData);
      isLoggedIn.value = true;
    }
  }

  // Register via Flask
<<<<<<< HEAD
  Future<bool> register(String email, String password, String name, {String rt = '', String rw = '', bool isEmailVerified = false}) async {
=======
  Future<bool> register(String email, String password, String name, {String rt = '', String rw = ''}) async {
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
    try {
      final response = await _api.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
        'role': 'warga',
        'rt': rt,
        'rw': rw,
<<<<<<< HEAD
        'is_email_verified': isEmailVerified,
=======
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
      });

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Get.snackbar('Sukses', data['message']);
        return true;
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Gagal Daftar', error['message'] ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      Get.snackbar('Error', 'Koneksi ke server gagal');
      debugPrint('Auth Error (register): $e');
    }
    return false;
  }

  // Login Email/Password via Flask
  Future<bool> loginWithEmail(String email, String password) async {
    try {
      final response = await _api.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        final userData = data['user'];

        // Store to GetStorage
        await _storage.write('token', token);
        await _storage.write('user', userData);

        currentUser.value = UserModel.fromJson(userData);
        isLoggedIn.value = true;
        return true;
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Gagal Login', error['message'] ?? 'Email atau password salah');
      }
    } catch (e) {
      Get.snackbar('Error', 'Koneksi ke server gagal');
      debugPrint('Auth Error (login): $e');
    }
    return false;
  }

  // Login dengan Google asli menggunakan Firebase Auth
  Future<bool> loginWithGoogle() async {
    try {
      debugPrint("Memulai Google Sign-In asli via Firebase...");
      
      // 1. Inisialisasi GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      
<<<<<<< HEAD
      // 2. Memicu login Google (Selalu paksa pilih akun)
      try {
        await googleSignIn.disconnect();
      } catch (_) {}
      try {
        await googleSignIn.signOut();
      } catch (_) {}
=======
      // 2. Memicu login Google
>>>>>>> 06708e303f4a6302f4456908d596a042c7882510
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser == null) {
        debugPrint('Google Sign-In dibatalkan oleh pengguna.');
        return false;
      }

      // 3. Ambil kredensial autentikasi Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 4. Buat credential Firebase Auth
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 5. Sign-in ke Firebase Auth menggunakan credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        Get.snackbar('Error', 'Gagal mendapatkan data pengguna dari Firebase Auth.');
        return false;
      }

      final String email = firebaseUser.email ?? '';
      final String name = firebaseUser.displayName ?? '';
      final String photoUrl = firebaseUser.photoURL ?? '';

      if (email.isEmpty) {
        Get.snackbar('Error', 'Gagal mendapatkan alamat email dari akun Google Anda.');
        return false;
      }

      // 6. Hubungkan ke backend Flask untuk membuat sesi JWT
      return await _processBackendGoogleLogin(email, name, photoUrl);

    } catch (e) {
      debugPrint('Real Google Auth Gagal: $e');
      Get.snackbar(
        'Gagal Autentikasi',
        'Gagal login dengan akun Google: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }
  }

  // Proses login ke backend Flask dengan email & profil Google asli
  Future<bool> _processBackendGoogleLogin(String email, String name, String photoUrl) async {
    try {
      final response = await _api.post('/auth/google-login', {
        'email': email,
        'name': name,
        'photo_url': photoUrl.isNotEmpty ? photoUrl : 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=80',
        'role': 'warga',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        final userData = data['user'];

        // Simpan sesi login ke GetStorage
        await _storage.write('token', token);
        await _storage.write('user', userData);

        currentUser.value = UserModel.fromJson(userData);
        isLoggedIn.value = true;
        
        Get.snackbar('Sukses', 'Berhasil masuk dengan Google');
        return true;
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Gagal Login', error['message'] ?? 'Gagal masuk melalui backend SIMPEL.');
      }
    } catch (e) {
      debugPrint('Backend Google Login Error: $e');
      Get.snackbar('Error', 'Gagal terhubung dengan server autentikasi SIMPEL.');
    }
    return false;
  }



  // Logout
  Future<void> logout() async {
    await _storage.remove('token');
    await _storage.remove('user');
    currentUser.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
