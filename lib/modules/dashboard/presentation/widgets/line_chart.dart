import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LineChartWidget extends StatelessWidget {
  final RxList<double> data;
  const LineChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 240, // Bu değeri de artırabilirsiniz, örneğin 240
        child: Obx(() {
          final spots = List<FlSpot>.generate(
            data.length,
            (i) => FlSpot(i.toDouble(), data[i]),
          );
          return LineChart(
            LineChartData(
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
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30, // ✅ Alt eksen etiketlerinin yer kaplaması
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40, // Zaten tanımlıydı, korundu
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  barWidth: 3,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF826CF6).withOpacity(0.15), // Mor mavi
                        const Color(0xFF826CF6).withOpacity(0.03),
                      ],
                    ),
                  ),
                  color: const Color(0xFF826CF6), // 🟣 Mor mavi
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
