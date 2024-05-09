import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projectx/data/transactions.dart';




List<BarChartGroupData> getCategoryBarGroup(String category, double categoryAmount) {
  double budgetAmount = _calculateBudgetAmount(category);

  switch (category) {
    case 'Mortgage':
    case 'Grocery':
    case 'Eat out':
    case 'Entertainment':
    case 'Shopping':
    case 'Transport':
    case 'Investments':
    case 'Rent':
    case 'Bills':
      return [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: categoryAmount,
              color: Colors.orange,
              width: 30,
            ),
            BarChartRodData(
              fromY: 0,
              toY: budgetAmount,
              color: Colors.orange,
              width: 30,
            ),
          ],
          showingTooltipIndicators: [0, 1],
        ),
      ];
    default:
      return [];
  }
}

double _calculateBudgetAmount(String category) {
  double totalAmount = 0;

  for (var transaction in myTransactionData) {
    if (transaction['name'] == category) {
      String amountString = transaction['totalAmount'].replaceAll('£', '');
      double amount = double.parse(amountString);
      totalAmount += amount;
    }
  }

  return totalAmount;
}