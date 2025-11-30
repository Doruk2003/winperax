import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PieChartWidget extends StatelessWidget {
  final RxMap<String, double> data;
  const PieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 240,
        child: Obx(() {
          final entries = data.entries.toList();
          final colors = [
            const Color.fromARGB(255, 219, 213, 110), // 🟡 Sarı
            const Color.fromARGB(255, 45, 147, 173), // 🔵 Mavi
            const Color.fromARGB(255, 136, 171, 117), // 🟢 Açık yeşil
            const Color.fromARGB(255, 222, 143, 110), // 🟠 Turuncu
          ];

          return Row(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 28,
                    sections: List.generate(entries.length, (i) {
                      final e = entries[i];
                      return PieChartSectionData(
                        value: e.value,
                        title: '${e.value.toInt()}%',
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
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(entries.length, (i) {
                  final e = entries[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: colors[i % colors.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          e.key,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
