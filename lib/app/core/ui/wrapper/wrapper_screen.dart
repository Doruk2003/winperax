import 'package:winperax/core/ui/home/dashboard_screen.dart';
import 'package:winperax/core/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/core/controllers/auth_controller.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.currentUser.value == null) {
        return LoginScreen();
      } else {
        return DashboardScreen();
      }
    });
  }
}
