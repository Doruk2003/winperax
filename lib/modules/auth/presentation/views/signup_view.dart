import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/auth/presentation/controllers/auth_controller.dart';

class SignupView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Yeni Hesap Oluştur",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // EMAIL
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),

              // PASSWORD
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 15),

              // PASSWORD AGAIN
              TextField(
                controller: passwordAgainController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Şifre Tekrar",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 25),

              // SIGNUP BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final passwordAgain = passwordAgainController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Get.snackbar("Hata", "Email ve şifre zorunludur");
                      return;
                    }

                    if (password != passwordAgain) {
                      Get.snackbar("Hata", "Şifreler uyuşmuyor!");
                      return;
                    }

                    await authController.signUp(email, password);
                  },
                  child: const Text("Kayıt Ol"),
                ),
              ),
              const SizedBox(height: 20),

              TextButton(
                onPressed: () => Get.offAllNamed("/login"),
                child: const Text("Zaten hesabın var mı? Giriş yap"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
