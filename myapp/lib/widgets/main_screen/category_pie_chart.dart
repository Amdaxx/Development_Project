import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryPieChart extends StatelessWidget {
  final List<PieChartSectionData> sections;

  const CategoryPieChart({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 150,
        child: PieChart(
          PieChartData(
            sections: sections,
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}