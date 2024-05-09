// transactions_screen.dart
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsScreen({Key? key, required this.transactions}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedCategory = 'All';
  String _selectedMonth = 'All';

  List<Map<String, dynamic>> getFilteredTransactions() {
    List<Map<String, dynamic>> filteredTransactions = widget.transactions;

    if (_selectedCategory != 'All') {
      filteredTransactions = filteredTransactions
          .where((tx) => tx['name'] == _selectedCategory)
          .toList();
    }

    if (_selectedMonth != 'All') {
      final selectedMonthYear = _selectedMonth.split(' ');
      final selectedMonth = _getMonthNumber(selectedMonthYear[0]);
      final selectedYear = int.parse(selectedMonthYear[1]);

      filteredTransactions = filteredTransactions
          .where((tx) {
            final dateParts = tx['date'].split('/');
            final month = int.parse(dateParts[1]);
            final year = int.parse(dateParts[2]);
            return month == selectedMonth && year == selectedYear;
          })
          .toList();
    }

    return filteredTransactions;
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'All';
      _selectedMonth = 'All';
    });
  }

  List<String> getUniqueMonthsAndYears() {
    final monthsAndYears = widget.transactions.map((tx) {
      final dateParts = tx['date'].split('/');
      final month = _getMonthName(int.parse(dateParts[1]));
      final year = dateParts[2];
      return '$month $year';
    }).toSet().toList();

    monthsAndYears.sort((a, b) {
      final aMonthYear = a.split(' ');
      final bMonthYear = b.split(' ');
      final aYear = int.parse(aMonthYear[1]);
      final bYear = int.parse(bMonthYear[1]);
      final aMonth = _getMonthNumber(aMonthYear[0]);
      final bMonth = _getMonthNumber(bMonthYear[0]);

      if (aYear != bYear) {
        return bYear.compareTo(aYear);
      } else {
        return bMonth.compareTo(aMonth);
      }
    });

    return monthsAndYears;
  }

  String _getMonthName(int monthNumber) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[monthNumber - 1];
  }

  int _getMonthNumber(String monthName) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames.indexOf(monthName) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: ['All', ...widget.transactions.map((tx) => tx['name']).toSet().toList()]
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: _selectedMonth,
                  items: ['All', ...getUniqueMonthsAndYears()]
                      .map((monthYear) => DropdownMenuItem<String>(
                            value: monthYear,
                            child: Text(monthYear),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMonth = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredTransactions().length,
              itemBuilder: (context, int i) {
                final transaction = getFilteredTransactions()[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: transaction['color'] ?? Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: transaction['icon'] ?? const Icon(Icons.error),
                      ),
                      title: Text(
                        transaction['transaction'] ?? 'Unknown Transaction',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        transaction['bank'] ?? 'Unknown Bank',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Text(
                        transaction['totalAmount'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}