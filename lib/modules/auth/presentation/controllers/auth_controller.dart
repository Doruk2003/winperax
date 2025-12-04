// 
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ Firestore import edildi
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart'; // ✅ DashboardController import edildi

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Giriş yapmış kullanıcıyı dinler
  Rx<User?> currentUser = Rx<User?>(null);

  // Loading state (UI göstermek için)
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// Firebase kullanıcı durum değişikliklerini dinle
    _auth.authStateChanges().listen((user) {
      currentUser.value = user;

      if (user != null) {
        // 🎯 Firestore'dan rol ve ismi çek, sonra dashboard'a aktar
        fetchUserRole(user.uid);
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/login');
      }
    });
  }

  /// Firestore'dan kullanıcının name ve role bilgilerini çeker
  Future<void> fetchUserRole(String uid) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        final name = data['name'] as String? ?? 'Kullanıcı';
        final role = data['role'] as String? ?? 'Kullanıcı';

        // DashboardController'a aktar
        final dashboardCtrl = Get.find<DashboardController>();
        dashboardCtrl.setUser(name, role);
      } else {
        // Belgelerde kullanıcı yoksa, email'den isim tahmini yap
        final name = currentUser.value?.email?.split('@').first ?? 'Kullanıcı';
        final dashboardCtrl = Get.find<DashboardController>();
        dashboardCtrl.setUser(name, 'Kullanıcı');
      }
    } catch (e) {
      // Hata durumunda varsayılan değerler
      print("Firestore'dan kullanıcı bilgisi çekilirken hata: $e");
      final dashboardCtrl = Get.find<DashboardController>();
      dashboardCtrl.setUser('Kullanıcı', 'Kullanıcı');
    }
  }

  /// Email / Password giriş
  Future<String?> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Kayıt ol (basit)
  Future<String?> signUp(String email, String password, {String? displayName}) async {
    try {
      isLoading.value = true;
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null) {
        await credential.user?.updateDisplayName(displayName);
        await credential.user?.reload();
      }

      // 🎯 Yeni kullanıcıyı Firestore'a kaydet (opsiyonel ama önerilir)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'email': email,
        'name': displayName ?? email.split('@').first,
        'role': 'Kullanıcı', // Varsayılan rol
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Password reset (forgot password)
  Future<String?> resetPassword(String email) async {
    if (email.isEmpty) return 'Email boş olamaz';
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);
      return null; // başarılı
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Şifre sıfırlama başarısız';
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Çıkış yap
  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}