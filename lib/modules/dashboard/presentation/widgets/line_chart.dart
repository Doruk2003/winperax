import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<double> data;
  const LineChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = List<FlSpot>.generate(
      data.length,
      (i) => FlSpot(i.toDouble(), data[i]),
    );
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 220,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 24),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
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
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.15),
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.03),
                    ],
                  ),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
