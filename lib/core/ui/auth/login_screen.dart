import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 👈 YENİ EKLENEN KISIM: SnackBar türlerini tanımlayan enum
enum SnackBarType { success, error, info }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'Invalid email format.';
          break;
        default:
          message = 'Login failed. Please try again.';
      }

      // 👈 YENİ EKLENEN KISIM: Hata mesajı için kırmızı SnackBar
      showCustomSnackBar(context, message, type: SnackBarType.error);
    } catch (_) {
      // 👈 YENİ EKLENEN KISIM: Genel hata için kırmızı SnackBar
      showCustomSnackBar(
        context,
        'Something went wrong. Try again later.',
        type: SnackBarType.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google ile oturum açma iptal edildi.');
        return null; // Kullanıcı seçim yapmadıysa null döner
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      print(
        'Google ile oturum açma başarılı: ${userCredential.user?.displayName}',
      );
      return userCredential; // Başarılıysa kullanıcı kimliğini döner
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null; // Hata durumunda null döner
    }
  }

  // 👈 YENİ EKLENEN KISIM: Facebook ile giriş (yer tutucu)
  Future<void> signInWithFacebook() async {
    // Buraya Facebook ile giriş işlemini ekleyeceksiniz.
    // Şimdilik sadece bir bilgi mesajı gösteriyoruz.
    showCustomSnackBar(
      context,
      'Facebook ile giriş şu anda desteklenmiyor.',
      type: SnackBarType.info,
    );
  }

  // 👈 YENİ EKLENEN KISIM: Mesaj tipine göre SnackBar gösteren yardımcı fonksiyon
  void showCustomSnackBar(
    BuildContext context,
    String message, {
    required SnackBarType type,
  }) {
    Color backgroundColor;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = Color(0xFF66BB6A); // Başarı için yeşil
      case SnackBarType.error:
        backgroundColor = Colors.red; // Hata için kırmızı
      case SnackBarType.info:
        backgroundColor = Colors.amber; // Bilgi için sarı
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3), // Gösterim süresi
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // 👈 Sayfa içeriğini kaydırılabilir yapar
        physics:
            const ClampingScrollPhysics(), // 👈 iOS'da elastik kaydırma efekti olmaz
        child: Column(
          children: [
            // Header with Gradient Background
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Hesabınıza Giriş Yapın.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight
                          .w500, // Montserrat Medium için w500 kullanılır
                      color: Colors.white,
                      fontFamily: 'Montserrat', // Font family belirtildi
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Devam etmek için bilgilerinizi girin...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[300],
                      fontFamily: 'Montserrat', // Font family belirtildi
                      fontWeight: FontWeight
                          .w300, // Montserrat Medium için w500 kullanılır
                    ),
                  ),
                ],
              ),
            ),

            // Padding ve Form widget'ları Expanded olmadan doğrudan Column'a eklenir
            Padding(
              padding: const EdgeInsets.only(
                top: 90,
              ), // 👈 Tasarım aşağı kaydırıldı
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(
                          fontSize: 12,
                        ), // 👈 YAZILAN METNİN FONT BÜYÜKLÜĞÜ AZALTILDI
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Email', // 👈 Yazı artık üstte (labelText)
                          labelStyle: const TextStyle(
                            fontSize: 14,
                          ), // 👈 Font küçültüldü
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // 👈 Her zaman üstte
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ), // 👈 GİRİNTİ EKLENDİ
                        ),
                        validator: (value) =>
                            value == null || !value.contains('@')
                            ? 'E_Mail adresinizi girin...'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(
                          fontSize: 12,
                        ), // 👈 YAZILAN METNİN FONT BÜYÜKLÜĞÜ AZALTILDI
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText:
                              'Password', // 👈 Yazı artık üstte (labelText)
                          labelStyle: const TextStyle(
                            fontSize: 14,
                          ), // 👈 Font küçültüldü
                          floatingLabelBehavior: FloatingLabelBehavior
                              .always, // 👈 Her zaman üstte
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade400,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ), // 👈 GİRİNTİ EKLENDİ
                        ),
                        validator: (value) => value != null && value.length < 6
                            ? 'Şifre en az 6 karakter olmalıdır'
                            : null,
                      ),

                      // Forgot Password Button
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot');
                        },
                        child: const Text(
                          'Şifrenizi mi unuttunuz?',
                          style: TextStyle(
                            color: Color(0xFF66BB6A),
                            fontSize: 12, // 👈 Font küçültüldü
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF66BB6A),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ), // 👈 Yükseklik azaltıldı (16 -> 12)
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Giriş Yap',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Or Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade200,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Veya giriş için bağlan...',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade200,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ), // 👈 Bu mesafeyi azalttım ki logo daha yakın olsun
                      // Google ve Facebook Logoları (Artık tıklanabilir ve yönlendirme yapar)
                      // Google ve Facebook Logoları (Artık tıklanabilir ve yönlendirme yapar)
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google Logo
                            InkWell(
                              onTap: () async {
                                final userCredential = await signInWithGoogle();
                                if (userCredential != null) {
                                  showCustomSnackBar(
                                    context,
                                    'Signed in as ${userCredential.user?.displayName}',
                                    type: SnackBarType.success,
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                } else {
                                  showCustomSnackBar(
                                    context,
                                    'Google ile oturum açma başarısız.',
                                    type: SnackBarType.error,
                                  );
                                }
                              },
                              child: Image.asset(
                                'assets/images/google.png',
                                width: 72,
                                height: 72,
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Facebook Logo
                            InkWell(
                              onTap: () async {
                                await signInWithFacebook();
                              },
                              child: Image.asset(
                                'assets/images/facebook.png',
                                width: 72,
                                height: 72,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ), // 👈 Bu mesafe logonun altındaki boşluk
                      // Not: Buton kaldırıldı
                    ],
                  ),
                ),
              ),
            ),

            // Bu Row, Column'un sonunda olduğu için daima en altta olur
            Padding(
              padding: const EdgeInsets.all(6.0), // İsteğe bağlı dış boşluk
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hesabınız yok mu?',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Kayıt yap...',
                      style: TextStyle(color: Color(0xFF66BB6A)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
