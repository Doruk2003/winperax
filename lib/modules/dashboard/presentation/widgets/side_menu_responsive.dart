import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/side_menu.dart';

class SideMenuResponsive extends StatelessWidget {
  SideMenuResponsive({super.key});
  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isDesktop = width > 1200;
    final isTablet = width > 800 && width <= 1200;

    // DESKTOP → geniş menü
    if (isDesktop) {
      return SizedBox(width: 260, child: SideMenu(isCompact: false));
    }

    // TABLET → compact menü
    if (isTablet) {
      return SizedBox(width: 96, child: SideMenu(isCompact: true));
    }

    // MOBILE → slide drawer
    return Obx(() {
      return AnimatedPositioned(
        duration: const Duration(milliseconds: 220),
        left: controller.isMenuOpen.value ? 0 : -260,
        top: 0,
        bottom: 0,
        child: SizedBox(
          width: 260,
          child: Material(
            elevation: 16,
            child: SideMenu(isCompact: false), // mobile = full menu
          ),
        ),
      );
    });
  }
}
