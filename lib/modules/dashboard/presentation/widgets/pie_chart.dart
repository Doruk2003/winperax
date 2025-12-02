import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final RxMap<String, double> data;
  const PieChartWidget({super.key, required this.data});

  // Ürün isimlerini eşle
  String _getLabel(String key) {
    switch (key) {
      case "Product A": return "Zip Perde";
      case "Product B": return "Pergola";
      case "Product C": return "Mafsallı Tente";
      case "Product D": return "Other";
      default: return key;
    }
  }

  Color _getColor(String key) {
    switch (key) {
      case "Product A": return const Color(0xFFFFC107); // Sarı
      case "Product B": return const Color(0xFF2196F3); // Mavi
      case "Product C": return const Color(0xFF9C27B0); // Mor
      case "Product D": return const Color(0xFF4CAF50); // Yeşil
      default: return const Color(0xFF4CAF50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16), // 👈 Üstü dar, altı geniş
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👉 Başlık
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

            // 👉 Grafik (daha aşağıda)
            Expanded(
              child: SizedBox(
                height: 220, // ✅ Daha fazla alan
                child: Obx(() {
                  return PieChart(
                    PieChartData(
                      sections: data.entries.map((entry) {
                        return PieChartSectionData(
                          value: entry.value,
                          color: _getColor(entry.key),
                          title: '${entry.value.toInt()}%', // Dilimin içinde yüzde
                          titleStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          radius: 70,
                          badgePositionPercentageOffset: 0.8,
                        );
                      }).toList(),
                      centerSpaceRadius: 40,
                      sectionsSpace: 2,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            // 👉 Liste: Büyükten küçüğe sıralı — dikdörtgen simgeler
            Obx(() {
              final sortedEntries = data.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final entry in sortedEntries)
                    Row(
                      children: [
                        // Renkli dikdörtgen (kare)
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: _getColor(entry.key),
                            borderRadius: BorderRadius.circular(2), // 👈 Hafif köşe yuvarlatma
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Ürün ismi + yüzde
                        Text(
                          "${_getLabel(entry.key)} (${entry.value.toInt()}%)",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
