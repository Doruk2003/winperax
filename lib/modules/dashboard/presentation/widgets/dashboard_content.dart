import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/stat_card.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/line_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/bar_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/pie_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/recent_activity_table.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  int _columnsForWidth(double w) {
    if (w > 1200) return 4;
    if (w > 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ===========================
          ///   STAT CARDS
          /// ===========================
          LayoutBuilder(
            builder: (ctx, constraints) {
              final cols = _columnsForWidth(constraints.maxWidth);
              final itemWidth = (constraints.maxWidth / cols) - 12;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: Obx(() {
                      final revenue = controller.stats['revenue'];
                      return StatCard(
                        icon: Icons.paid,
                        title: 'Gelir',
                        value: '\$$revenue',
                        delta: '+8%',
                        color: Colors.green,
                      );
                    }),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: Obx(() {
                      final orders = controller.stats['orders'];
                      return StatCard(
                        icon: Icons.shopping_cart,
                        title: 'Sipariş',
                        value: '$orders',
                        delta: '+3%',
                        color: Colors.blue,
                      );
                    }),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: Obx(() {
                      final customers = controller.stats['customers'];
                      return StatCard(
                        icon: Icons.people,
                        title: 'Müşteri',
                        value: '$customers',
                        delta: '+1.2%',
                        color: Colors.orange,
                      );
                    }),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: Obx(() {
                      final conversion = controller.stats['conversion'];
                      return StatCard(
                        icon: Icons.show_chart,
                        title: 'Dönüşüm',
                        value: '$conversion%',
                        delta: '-0.4%',
                        color: Colors.purple,
                      );
                    }),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          /// ===========================
          ///   CHARTS
          /// ===========================
          LayoutBuilder(
            builder: (ctx, constraints) {
              final w = constraints.maxWidth;

              if (w > 1200) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LineChartWidget( data: controller.lineData), // ✅ named parameter
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BarChartWidget( data: controller.barData), // ✅ named parameter
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 320,
                      child: PieChartWidget( data: controller.pieData), // ✅ named parameter
                    ),
                  ],
                );
              }

              if (w > 800) {
                return Row(
                  children: [
                    Expanded(
                      child: LineChartWidget( data: controller.lineData), // ✅ named parameter
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 320,
                      child: PieChartWidget( data: controller.pieData), // ✅ named parameter
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  LineChartWidget( data: controller.lineData), // ✅ named parameter
                  const SizedBox(height: 12),
                  BarChartWidget( data: controller.barData), // ✅ named parameter
                  const SizedBox(height: 12),
                  PieChartWidget( data: controller.pieData), // ✅ named parameter
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          /// ===========================
          ///   RECENT ACTIVITY TABLE
          /// ===========================
          const RecentActivityTable(),
        ],
      ),
    );
  }
}