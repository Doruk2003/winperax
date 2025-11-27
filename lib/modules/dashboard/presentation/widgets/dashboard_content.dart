import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winperax/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/stat_card.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/line_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/bar_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/pie_chart.dart';
import 'package:winperax/modules/dashboard/presentation/widgets/recent_activity_table.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent({super.key});
  final controller = Get.find<DashboardController>();

  // responsive grid column count
  int _columnsForWidth(double w) {
    if (w > 1200) return 4;
    if (w > 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // TOP ROW: Stat cards
          LayoutBuilder(
            builder: (ctx, constraints) {
              final cols = _columnsForWidth(constraints.maxWidth);
              return Wrap(
                runSpacing: 12,
                spacing: 12,
                children: [
                  SizedBox(
                    width: constraints.maxWidth / cols - 12,
                    child: Obx(() {
                      return StatCard(
                        icon: Icons.paid,
                        title: 'Gelir',
                        value: '\$${controller.stats['revenue']}',
                        delta: '+8%',
                        color: Colors.green,
                      );
                    }),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / cols - 12,
                    child: Obx(() {
                      return StatCard(
                        icon: Icons.shopping_cart,
                        title: 'Sipariş',
                        value: '${controller.stats['orders']}',
                        delta: '+3%',
                        color: Colors.blue,
                      );
                    }),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / cols - 12,
                    child: Obx(() {
                      return StatCard(
                        icon: Icons.people,
                        title: 'Müşteri',
                        value: '${controller.stats['customers']}',
                        delta: '+1.2%',
                        color: Colors.orange,
                      );
                    }),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / cols - 12,
                    child: Obx(() {
                      return StatCard(
                        icon: Icons.show_chart,
                        title: 'Dönüşüm',
                        value: '${controller.stats['conversion']}%',
                        delta: '-0.4%',
                        color: Colors.purple,
                      );
                    }),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          // CHARTS ROW
          LayoutBuilder(
            builder: (ctx, constraints) {
              final w = constraints.maxWidth;
              if (w > 1200) {
                // big screens: line + bar + pie side by side
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(
                        () => LineChartWidget(data: controller.lineData),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Obx(
                        () => BarChartWidget(data: controller.barData),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 320,
                      child: Obx(
                        () => PieChartWidget(data: controller.pieData),
                      ),
                    ),
                  ],
                );
              } else if (w > 800) {
                // tablet: line + pie
                return Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => LineChartWidget(data: controller.lineData),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 320,
                      child: Obx(
                        () => PieChartWidget(data: controller.pieData),
                      ),
                    ),
                  ],
                );
              } else {
                // mobile: stacked
                return Column(
                  children: [
                    Obx(() => LineChartWidget(data: controller.lineData)),
                    const SizedBox(height: 12),
                    Obx(() => BarChartWidget(data: controller.barData)),
                    const SizedBox(height: 12),
                    Obx(() => PieChartWidget(data: controller.pieData)),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 16),

          // Recent activity table
          const RecentActivityTable(),
        ],
      ),
    );
  }
}
