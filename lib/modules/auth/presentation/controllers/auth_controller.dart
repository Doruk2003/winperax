import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        // Kullanıcı giriş yaptıysa ana sayfaya yönlendirme gibi davranışlar
        // Ancak navigation'ı burada zorlamak istemezsen kaldırabilirsin
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    });
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
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (displayName != null) {
        await credential.user?.updateDisplayName(displayName);
        await credential.user?.reload();
      }
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
