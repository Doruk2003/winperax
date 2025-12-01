import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_appbar.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/side_menu_responsive.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/line_chart.dart'; // ✅
import 'package:winperax/modules/dashboard/presentation/widgets/bar_chart.dart'; // ✅
import 'package:winperax/modules/dashboard/presentation/widgets/recent_activity_table.dart'; // ✅
import 'package:winperax/modules/dashboard/presentation/widgets/pie_chart.dart'; // ✅

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

                    // 👇 1. Satır: DashboardContent (kartlar) - %20 oranında
                    Expanded(
                      flex: 1, // %20
                      child: DashboardContent(), // ✅ Card'ların yüksekliği artırıldı
                    ),

                    const SizedBox(height: 10), // ✅ Arada 10 piksel boşluk

                    // 👇 2. Satır: LineChart + BarChart - %30 oranında
                    Expanded(
                      flex: 4, // %30
                      child: Row(
                        children: [
                          Expanded(child: LineChartWidget(data: controller.lineData)),
                          const SizedBox(width: 10), // ✅ Grafikler arası 10 piksel boşluk
                          Expanded(child: BarChartWidget(data: controller.barData)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10), // ✅ Arada 10 piksel boşluk

                    // 👇 3. Satır: RecentActivityTable + PieChart - %50 oranında
                    Expanded(
                      flex: 5, // %50
                      child: Row(
                        children: [
                          // ✅ Sol: Son İşlemler Tablosu (3 kart genişliğinde)
                          Expanded(
                            flex: 3, // %75 genişlik
                            child: RecentActivityTable(),
                          ),
                          const SizedBox(width: 10), // ✅ Tablo ve pie chart arası 10 piksel boşluk
                          // ✅ Sağ: Pie Chart (1 kart genişliğinde)
                          Expanded(
                            flex: 1, // %25 genişlik
                            child: PieChartWidget(data: controller.pieData),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10), // ✅ Altta 10 piksel boşluk
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