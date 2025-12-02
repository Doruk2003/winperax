import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final RxList<double> data;
  const LineChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Aylık Verilen Teklif Sayısı",
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
                if (data.length < 12) {
                  data.assignAll([
                    520, 450, 570, 775, 850, 870,
                    900, 990, 800, 700, 600, 550
                  ]);
                }

                // ✅ X değerleri 1'den 12'ye kadar
                final spots = List<FlSpot>.generate(
                  data.length,
                  (i) => FlSpot((i + 1).toDouble(), data[i]),
                );

                return LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: const Color(0xFF4B5563),
                        strokeWidth: 0.5,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: const Color(0xFF4B5563),
                        strokeWidth: 0.5,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      // 📅 X EKSENİ - ALT: AY İSİMLERİ (TEK KERE)
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            // ✅ Sadece tam sayı x değerlerinde metin göster
                            if (value == value.toInt().toDouble()) {
                              final index = value.toInt();
                              if (index >= 1 && index <= 12) {
                                final months = [
                                  'Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz',
                                  'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'
                                ];
                                return Text(
                                  months[index - 1],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                );
                              }
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      // 📅 X EKSENİ - ÜST: RAKAMLAR (TEK KERE)
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            // ✅ Sadece tam sayı x değerlerinde metin göster
                            if (value == value.toInt().toDouble()) {
                              final index = value.toInt();
                              if (index >= 1 && index <= 12) {
                                return Text(
                                  '$index',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.black54,
                                  ),
                                );
                              }
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      // 📏 SOL Y EKSENİ
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 200,
                          getTitlesWidget: (value, meta) {
                            if (value % 200 == 0 && value <= 1200) {
                              return Text(
                                '${value.toInt()}',
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
                      // 📏 SAĞ Y EKSENİ
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 200,
                          getTitlesWidget: (value, meta) {
                            if (value % 200 == 0 && value <= 1200) {
                              return Text(
                                '${value.toInt()}',
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
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(colors: [
                            // ignore: deprecated_member_use
                            const Color(0xFF826CF6).withOpacity(0.15),
                            // ignore: deprecated_member_use
                            const Color(0xFF826CF6).withOpacity(0.03),
                          ]),
                        ),
                        color: const Color(0xFF826CF6),
                      ),
                    ],
                    maxY: 1200,
                    minY: 0,
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