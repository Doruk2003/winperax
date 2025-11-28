import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BarChartWidget extends StatelessWidget {
  final RxList<double> data;
  const BarChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 200,
        child: Obx(() {
          final groups = List.generate(data.length, (i) {
            return BarChartGroupData(x: i, barRods: [BarChartRodData(toY: data[i], color: const Color(0xFFFF9900))]); // 🟠 Turuncu
          });
          return BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: true,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: const Color(0xFF4B5563), // Gri grid
                  strokeWidth: 0.5,
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: const Color(0xFF4B5563), // Gri grid
                  strokeWidth: 0.5,
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              ),
              barGroups: groups,
            ),
          );
        }),
      ),
    );
  }
}