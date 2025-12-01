import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final RxMap<String, double> data;
  const PieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Başlık ekle
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Teklif Sistem Dağılımı",
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
                return SizedBox(
                  height: 180, // ✅ Yükseklik 180 piksel
                  child: PieChart(
                    PieChartData(
                      sections: data.entries.map((entry) {
                        return PieChartSectionData(
                          value: entry.value,
                          color: _getColor(entry.key),
                          title: '${entry.value}%', // Yüzde gösterimi
                          radius: 60, // ✅ Radius 60 olarak küçültüldü
                        );
                      }).toList(),
                      centerSpaceRadius: 20, // ✅ Merkez boşluğu küçültüldü
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String key) {
    switch (key) {
      case "Product A":
        return const Color(0xFFFFC107);
      case "Product B":
        return const Color(0xFF2196F3);
      case "Product C":
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFF4CAF50);
    }
  }
}