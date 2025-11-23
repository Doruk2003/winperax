import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// SnackBar Tipleri
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // >>> Google SignIn Client ID (Web için zorunlu, diğerleri için gerekmez)
  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: _getClientIdForPlatform(),
  );

  // >>> Platforma göre clientId belirle
  String? _getClientIdForPlatform() {
    const webClientId =
        "454971816334-ci76mqo11m03s7ivvsb948l82p4cpggv.apps.googleusercontent.com";

    // Sadece web'de client ID gerekir
    if (kIsWeb) {
      return webClientId;
    }
    // Android, iOS, Windows, macOS, Linux → client ID gerekmez
    return null;
  }

  // -------------------------------------------------------------------------
  //  EMAIL / PASSWORD LOGIN
  // -------------------------------------------------------------------------
  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Kullanıcı bulunamadı.';
          break;
        case 'wrong-password':
          message = 'Şifre hatalı.';
          break;
        case 'invalid-email':
          message = 'Email formatı hatalı.';
          break;
        default:
          message = 'Giriş başarısız.';
      }

      showCustomSnackBar(context, message, type: SnackBarType.error);
    } catch (_) {
      showCustomSnackBar(context, 'Bir hata oluştu.', type: SnackBarType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // -------------------------------------------------------------------------
  //  GOOGLE SIGN-IN (TÜM PLATFORM)
  // -------------------------------------------------------------------------
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        showCustomSnackBar(
          context,
          'Google ile giriş iptal edildi.',
          type: SnackBarType.info,
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // -------------------------------------------------------------------------
  //  FACEBOOK (Yer tutucu)
  // -------------------------------------------------------------------------
  Future<void> signInWithFacebook() async {
    showCustomSnackBar(
      context,
      'Facebook ile giriş desteklenmiyor.',
      type: SnackBarType.info,
    );
  }

  // -------------------------------------------------------------------------
  //  SNACKBAR
  // -------------------------------------------------------------------------
  void showCustomSnackBar(
    BuildContext context,
    String message, {
    required SnackBarType type,
  }) {
    Color backgroundColor;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = const Color(0xFF66BB6A);
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.amber;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  //  UI
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            //////////////////////////////////////////////////////////////////////////
            /// HEADER
            //////////////////////////////////////////////////////////////////////////
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
                children: const [
                  SizedBox(height: 50),
                  Text(
                    'Hesabınıza Giriş Yapın.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Devam etmek için bilgilerinizi girin...',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            //////////////////////////////////////////////////////////////////////////
            /// FORM
            //////////////////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // EMAIL ★
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            value == null || !value.contains('@')
                            ? 'E-mail adresinizi girin...'
                            : null,
                        decoration: _inputDecoration("Email"),
                      ),
                      const SizedBox(height: 14),

                      // PASSWORD ★
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) => value != null && value.length < 6
                            ? 'Şifre en az 6 karakter olmalı'
                            : null,
                        decoration: _passwordDecoration(),
                      ),

                      // FORGOT PASSWORD ★
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/forgot'),
                        child: const Text(
                          'Şifrenizi mi unuttunuz?',
                          style: TextStyle(
                            color: Color(0xFF66BB6A),
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      // LOGIN BUTTON ★
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF66BB6A),
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                              : const Text('Giriş Yap'),
                        ),
                      ),

                      const SizedBox(height: 20),

                      //////////////////////////////////////////////////////////////////////////
                      /// OR DIVIDER
                      //////////////////////////////////////////////////////////////////////////
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Veya giriş için bağlan...',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      //////////////////////////////////////////////////////////////////////////
                      /// GOOGLE + FACEBOOK BUTTONS
                      //////////////////////////////////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // GOOGLE BUTTON
                          InkWell(
                            onTap: () async {
                              final userCredential = await signInWithGoogle();

                              if (userCredential != null) {
                                showCustomSnackBar(
                                  context,
                                  "Hoş geldin, ${userCredential.user?.displayName}",
                                  type: SnackBarType.success,
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/home",
                                );
                              } else {
                                showCustomSnackBar(
                                  context,
                                  'Google ile giriş başarısız.',
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

                          InkWell(
                            onTap: signInWithFacebook,
                            child: Image.asset(
                              'assets/images/facebook.png',
                              width: 72,
                              height: 72,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),

            //////////////////////////////////////////////////////////////////////////
            /// SIGNUP
            //////////////////////////////////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hesabınız yok mu?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
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

  // -------------------------------------------------------------------------
  //  INPUT DECORATIONS
  // -------------------------------------------------------------------------

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _focusedBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  InputDecoration _passwordDecoration() {
    return InputDecoration(
      labelText: 'Password',
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _focusedBorder(),
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.green.shade400, width: 2),
    );
  }
}
