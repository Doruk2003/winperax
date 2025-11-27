import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/side_menu.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_content.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Obx scope'u içinde controller'ı al
    final controller = Get.find<DashboardController>();

    return Scaffold(
      body: Row(
        children: [
          // Desktop side menu
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return SideMenu();
              }
              return const SizedBox.shrink();
            },
          ),

          // main content
          Expanded(
            child: Obx(() {
              return DashboardContent(menuIndex: controller.selectedMenuIndex.value);
            }),
          ),
        ],
      ),
    );
  }
}
