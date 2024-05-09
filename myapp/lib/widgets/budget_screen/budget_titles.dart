import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text('${value.toInt()}', style: style),
  );
}

Widget bottomTitles(double value, TitleMeta meta, String filter) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  String label;
  switch (value.toInt()) {
    case 0:
      label = filter == 'all' ? 'Total Spending' : 'Expected   Actual';
      break;
    case 1:
      label = 'Grocery';
      break;
    case 2:
      label = 'Eat Out';
      break;
    case 3:
      label = 'Entertainment';
      break;
    case 4:
      label = 'Shopping';
      break;
    case 5:
      label = 'Transport';
      break;
    case 6:
      label = 'Investments';
      break;
    case 7:
      label = 'Rent';
      break;
    default:
      label = '';
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(label, style: style),
  );
}