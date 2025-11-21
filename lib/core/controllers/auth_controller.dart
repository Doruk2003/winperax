import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    // Kullanıcı değişikliklerini dinle
    _auth.authStateChanges().listen((User? user) {
      currentUser.value = user;
    });
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login'); // Login ekranına git ve stack'i temizle
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    }
  }
}
