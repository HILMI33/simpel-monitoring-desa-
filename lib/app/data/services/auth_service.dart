import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // Register Email/Password
  Future<UserModel?> registerWithEmail(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User? user = userCredential.user;
      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
        );
        // Save to Firestore
        await Get.find<FirestoreService>().saveUser(newUser);
        return newUser;
      }
    } catch (e) {
      Get.snackbar('Register Error', e.toString());
    }
    return null;
  }

  // Login Email/Password
  Future<bool> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      Get.snackbar('Login Error', 'Email atau password salah');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
