import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final List<double> data;
  const BarChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = List.generate(
      data.length,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i],
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 200,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            ),
            barGroups: spots,
          ),
        ),
      ),
    );
  }
}
