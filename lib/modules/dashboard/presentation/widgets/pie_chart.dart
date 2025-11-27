// FILE: lib/modules/dashboard/presentation/widgets/pie_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const PieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.toList();

    // Pie renkleri (otomatik döner)
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Colors.amber,
      Colors.green,
      Colors.pink,
      Colors.blueGrey,
    ];

    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 220,
        child: Row(
          children: [
            // Pie chart
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 28,
                  sections: List.generate(entries.length, (i) {
                    final item = entries[i];
                    return PieChartSectionData(
                      value: item.value,
                      title: "${item.value.toInt()}%",
                      color: colors[i % colors.length],
                      radius: 48,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Legend
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(entries.length, (i) {
                final item = entries[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colors[i % colors.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.key,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
