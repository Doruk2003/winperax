import 'package:winperax/core/ui/auth/forgot_password_screen.dart';
import 'package:winperax/core/ui/auth/login_screen.dart';
import 'package:winperax/core/ui/auth/otp_screen.dart';
import 'package:winperax/core/ui/auth/signup_screen.dart';
import 'package:winperax/core/ui/home/dashboard_screen.dart';
// import 'package:winperax/ui/wrapper/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/core/theme/app_theme.dart';
import 'package:winperax/core/controllers/auth_controller.dart';
import 'package:winperax/core/controllers/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(ThemeController());

    return GetMaterialApp(
      title: 'WINPERAX UI',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      getPages: [
        // GetPage(name: '/', page: () => const WrapperScreen()),
        GetPage(name: '/home', page: () => DashboardScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/forgot', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/otp', page: () => const OtpScreen()),
      ],
    );
  }
}
