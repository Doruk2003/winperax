import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/side_menu.dart';

class SideMenuResponsive extends StatelessWidget {
  const SideMenuResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1200;
    final isTablet = width > 800 && width <= 1200;

    if (isDesktop) {
      return Obx(() => SizedBox(
            width: controller.isCompact.value ? 96 : 260, // Genişliği de dinamik yapabiliriz
            child: SideMenu(isCompact: controller.isCompact.value),
          ));
    }

    // ✅ Tablet için de controller.isCompact.value kullan
    if (isTablet) {
      return Obx(() => SizedBox(
            width: controller.isCompact.value ? 96 : 260, // Genişliği de dinamik yapabiliriz
            child: SideMenu(isCompact: controller.isCompact.value),
          ));
    }

    // Mobil: Controller'ı dinlemeden sabit menü
    return Obx(() {
      // mobile drawer slide
      return AnimatedPositioned(
        duration: const Duration(milliseconds: 220),
        left: controller.isMenuOpen.value ? 0 : -260,
        top: 0,
        bottom: 0,
        child: SizedBox(
          width: 260,
          child: Material(elevation: 16, child: const SideMenu(isCompact: false)),
        ),
      );
    });
  }
}