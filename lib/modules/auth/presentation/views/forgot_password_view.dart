import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/auth/presentation/controllers/auth_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre Sıfırlama'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEEF2F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              const Text(
                'E-posta adresini gir, sana sıfırlama linki gönderelim.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) => value == null || !value.contains('@')
                    ? 'Geçerli bir email girin'
                    : null,
              ),
              const SizedBox(height: 20),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : _onSendPressed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: authController.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Sıfırlama Linki Gönder'),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _onSendPressed() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar(
        'Hata',
        'Lütfen geçerli bir e-posta girin',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final result = await authController.resetPassword(email);

    if (result == null) {
      Get.snackbar(
        'Başarılı',
        'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.',
        snackPosition: SnackPosition.BOTTOM,
      );
      // opsiyonel: otomatik geri dön
      Get.back();
    } else {
      Get.snackbar('Hata', result, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
