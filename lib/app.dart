import 'package:firebase_core/firebase_core.dart';
import 'package:winperax/app/core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:winperax/modules/auth/presentation/views/login_view.dart';
import 'package:winperax/modules/auth/presentation/views/signup_view.dart';
import 'package:winperax/modules/auth/presentation/views/forgot_password_view.dart';
import 'package:winperax/modules/auth/presentation/views/otp_screen.dart';
import 'package:winperax/app/core/controllers/theme_controller.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart'; // 👈 EKLE
import 'package:winperax/modules/dashboard/presentation/views/dashboard_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 en kritik satır
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Global Controller Inject
    Get.put(AuthController());
    Get.put(ThemeController());
    Get.put(DashboardController()); // 👈 BURAYA EKLEYİN

    return GetMaterialApp(
      title: 'WINPERAX UI',
      debugShowCheckedModeBanner: false,

      // 🎨 Modern AppTheme Kullanımı
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // 🔗 Başlangıç sayfası
      initialRoute: '/login',

      // 🔗 Sayfa rotaları
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/signup', page: () => SignupView()),
        GetPage(name: '/forgot', page: () => ForgotPasswordView()),
        GetPage(name: '/otp', page: () => OtpScreen()),
        GetPage(name: '/dashboard', page: () => const DashboardView()),
      ],
    );
  }
}
