import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_appbar.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/side_menu_responsive.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/line_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/bar_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/recent_activity_table.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/pie_chart.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

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
                    const SizedBox(height: 16), // 👈 Sabit üst boşluk

                    // 👇 1. Satır: Kartlar – SABİT YÜKSEKLİK (Overflow önleme)
                    SizedBox(
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DashboardContent(),
                      ),
                    ),
                    const SizedBox(height: 16), // 👈 Sabit boşluk

                    // 👇 2. Satır: Grafikler – Esnek (%30)
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(child: LineChartWidget(data: controller.lineData)),
                            const SizedBox(width: 16), // 👈 Sabit yatay boşluk
                            Expanded(child: BarChartWidget(data: controller.barData)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // 👈 Sabit boşluk

                    // 👇 3. Satır: Tablo + Pie Chart – Esnek (%50)
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: RecentActivityTable(),
                            ),
                            const SizedBox(width: 16), // 👈 Sabit yatay boşluk
                            Expanded(
                              flex: 1,
                              child: PieChartWidget(data: controller.pieData),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // 👈 Sabit alt boşluk
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
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}