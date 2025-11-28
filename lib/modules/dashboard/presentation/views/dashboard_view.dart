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
    final controller = Get.find<DashboardController>(); // 👈 Bu satır eklendi

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              SideMenuResponsive(),

              Expanded(
                child: Column(
                  children: [
                    const DashboardAppBar(),
                    const SizedBox(height: 8),

                    const Expanded(child: DashboardContent()),
                  ],
                ),
              ),
            ],
          ),

          /// MOBILE OVERLAY
          Obx(() {
            final isMobile = MediaQuery.of(context).size.width < 800;
            final menuOpen = controller.isMenuOpen.value;

            if (!isMobile || !menuOpen) return const SizedBox.shrink();

            return GestureDetector(
              onTap: () => controller.isMenuOpen.value = false,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: menuOpen ? 1 : 0,
                child: Container(
                  color: Colors.black.withOpacity(.35),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}