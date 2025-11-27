import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/auth/presentation/controllers/auth_controller.dart';


class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController controller = Get.find();

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          return Row(
            children: [
              // -------- LEFT SIDE (Form Area) --------
              Expanded(
                flex: isDesktop ? 4 : 10,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo
                          Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/winperax.png",
                                  height: 70,
                                ),
                                const SizedBox(height: 12),
                                // Text(
                                //   "WINPERAX",
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headlineMedium
                                //       ?.copyWith(fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          Text(
                            "Hoş Geldin 👋",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Montserrat",
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Hesabına giriş yaparak devam et.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const SizedBox(height: 40),

                          // Email Input
                          TextField(
                            controller: emailCtrl,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Password Input
                          TextField(
                            controller: passwordCtrl,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Şifre",
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed("/forgot");
                              },
                              child: const Text("Şifremi Unuttum"),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Login Button
                          Obx(() {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : () async {
                                        final error = await controller.signIn(
                                          emailCtrl.text.trim(),
                                          passwordCtrl.text.trim(),
                                        );

                                        if (error != null) {
                                          Get.snackbar(
                                            "Giriş Hatası",
                                            error,
                                            // backgroundColor: Colors.red.withOpacity(.8),
                                            backgroundColor: Colors.red.withValues(alpha: 0.8),

                                            colorText: Colors.white,
                                          );
                                        }
                                      },
                                child: controller.isLoading.value
                                    ? const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text("Giriş Yap"),
                              ),
                            );
                          }),

                          const SizedBox(height: 30),

                          // Signup
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Hesabın yok mu? "),
                              GestureDetector(
                                onTap: () => Get.toNamed("/signup"),
                                child: Text(
                                  "Kayıt Ol",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // -------- RIGHT SIDE (Illustration Only on Desktop) --------
              if (isDesktop)
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.grey.shade100,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/illustrations/login_illustration.png",
                        width: constraints.maxWidth * 0.30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

