import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_appbar.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/side_menu_responsive.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_content.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // ensure controller is available
    Get.put(DashboardController());
    final controller = Get.find<DashboardController>();

    return Scaffold(
      appBar: DashboardAppBar(),
      body: Stack(
        children: [
          Row(
            children: [
              SideMenuResponsive(),
              Expanded(child: DashboardContent()),
            ],
          ),

          // mobile overlay when menu open
          Obx(() {
            final isMobile = MediaQuery.of(context).size.width < 800;
            if (!isMobile || !controller.isMenuOpen.value) {
              return const SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () => controller.isMenuOpen.value = false,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: controller.isMenuOpen.value ? 1 : 0,
                child: Container(color: Colors.black.withValues(alpha: 0.35)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
