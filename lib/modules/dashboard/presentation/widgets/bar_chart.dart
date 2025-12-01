import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  final RxList<double> data;
  const BarChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 500, // ✅ Yükseklik 200 piksel
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Aylık Onaylanan Teklif Sayısı",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                final groups = List.generate(data.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: data[i],
                        color: const Color(0xFFFF9900), // 🟠 Turuncu
                      ),
                    ],
                  );
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
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < 7) { // ✅ Sadece 0-6 göster
                              return Text(
                                '$index',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                        ),
                      ),
                    ),
                    barGroups: groups,
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