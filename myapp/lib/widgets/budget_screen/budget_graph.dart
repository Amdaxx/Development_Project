import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'budget_bar_group.dart';
import 'budget_titles.dart';

class BudgetChart extends StatefulWidget {
  final double budgetAmount;
  final double totalSpending;
  final double mortgageAmount;
  final double foodAmount;
  final double eatOutAmount;
  final double entertainmentAmount;
  final double shoppingAmount;
  final double transportAmount;
  final double investmentsAmount;
  final double rentAmount;
  final String userId;

  BudgetChart({
    required this.budgetAmount,
    required this.totalSpending,
    required this.mortgageAmount,
    required this.foodAmount,
    required this.eatOutAmount,
    required this.entertainmentAmount,
    required this.shoppingAmount,
    required this.transportAmount,
    required this.investmentsAmount,
    required this.rentAmount,
    required this.userId,
  });

  @override
  _BudgetChartState createState() => _BudgetChartState();
}

class _BudgetChartState extends State<BudgetChart> {
  String _categoryFilter = 'all';
  String _dateFilter = DateFormat('MMMM yyyy').format(DateTime.now());
  bool _budgetExists = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: _budgetExists
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Budget vs Actual',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: _categoryFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            _categoryFilter = newValue!;
                          });
                        },
                        items: <String>[
                          'all',
                          'Mortgage',
                          'Grocery',
                          'Eat out',
                          'Entertainment',
                          'Shopping',
                          'Transport',
                          'Investments',
                          'Rent',
                          'Bills',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: _dateFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            _dateFilter = newValue!;
                          });
                        },
                        items: List.generate(4, (index) {
                          final now = DateTime.now();
                          final month = DateFormat('MMMM').format(DateTime(now.year, now.month - index));
                          final year = DateTime(now.year, now.month - index).year;
                          return '$month $year';
                        }).map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 400,
                    child: BarChart(
                      BarChartData(
                        barGroups: _categoryFilter == 'all'
                            ? [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(
                                      fromY: 0,
                                      toY: 1550,
                                      color: Colors.orange,
                                      width: 30,
                                    ),
                                    BarChartRodData(
                                      fromY: 0,
                                      toY: 1000.53,
                                      color: Colors.orange,
                                      width: 30,
                                    ),
                                  ],
                                  showingTooltipIndicators: [0, 1],
                                ),
                              ]
                            : getCategoryBarGroup(_categoryFilter, _getCategoryAmount(_categoryFilter, _dateFilter)),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) => bottomTitles(value, meta, _categoryFilter),
                              reservedSize: 30,
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          drawVerticalLine: false,
                          horizontalInterval: 1000,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barTouchData: BarTouchData(
                          enabled: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await deleteBudget(widget.userId);
                        setState(() {
                          _budgetExists = false;
                        });
                      },
                      child: Text('Delete Budget'),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Budget deleted',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the screen to create a new budget
                      },
                      child: Text('Create New Budget'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  double _getCategoryAmount(String category, String dateFilter) {
    final selectedDate = _getSelectedDate(dateFilter);

    switch (category) {
      case 'Mortgage':
        return widget.mortgageAmount;
      case 'Grocery':
        return widget.foodAmount;
      case 'Eat out':
        return widget.eatOutAmount;
      case 'Entertainment':
        return widget.entertainmentAmount;
      case 'Shopping':
        return widget.shoppingAmount;
      case 'Transport':
        return widget.transportAmount;
      case 'Investments':
        return widget.investmentsAmount;
      case 'Rent':
        return widget.rentAmount;
      case 'Bills':
        return widget.rentAmount;
      default:
        if (selectedDate != null) {
          // Filter the data based on the selected month and year
          // Implement your logic here to retrieve the data for the selected month and year
          // For example, you can query your data source (e.g., Firestore) to get the data for the specific month and year
          // and return the corresponding amount for the selected category
        }
        return 0.0;
    }
  }

  DateTime? _getSelectedDate(String dateFilter) {
    final parts = dateFilter.split(' ');
    final month = DateFormat('MMMM').parse(parts[0]);
    final year = int.parse(parts[1]);
    return DateTime(year, month.month);
  }

  Future<void> deleteBudget(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('budget').doc(userId).delete();
      print('Budget deleted successfully');
    } catch (e) {
      print('Error deleting budget: $e');
    }
  }
}