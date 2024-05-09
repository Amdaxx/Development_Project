import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectx/widgets/main_screen/balance_card.dart';
import 'package:projectx/widgets/main_screen/transaction_header.dart';
import 'package:projectx/widgets/main_screen/transactions_list.dart';
import 'package:projectx/data/transactions.dart';
import 'package:projectx/screens/transactions_screen.dart';
import 'package:projectx/widgets/main_screen/user_greeting.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedBank = 'All';
  List<String> _bankNames = [];

  List<DateTime> getAvailableDates() {
    Set<DateTime> dateSet = {};
    for (var transaction in myTransactionData) {
      DateTime transactionDate = DateFormat('dd/MM/yyyy').parse(transaction['date']);
      dateSet.add(DateTime(transactionDate.year, transactionDate.month));
    }
    return dateSet.toList()..sort();
  }

  @override
  void initState() {
    super.initState();
    _fetchBankNames();
    List<DateTime> availableDates = getAvailableDates();
    if (availableDates.isNotEmpty) {
      _selectedDate = availableDates.last;
    }
  }

  Future<void> _fetchBankNames() async {
    try {
      // Get the current user's UID
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch bank names from Firestore using the user's UID
        final snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        print('Snapshot data: ${snapshot.data()}'); // Print the snapshot data
        final data = snapshot.data();
        final accessToken = List<String>.from(data?['accessToken'] ?? []);
        final nooBanks = data?['nooBanks'] ?? 0;

        setState(() {
          _bankNames = accessToken;
          if (nooBanks > 1) {
            _bankNames.insert(0, 'All');
          }
          print('Bank names: $_bankNames'); // Print the bank names for debugging
        });
      } else {
        print('No user is currently signed in.');
        // Handle the case when no user is signed in
      }
    } catch (e) {
      print('Error fetching bank names: $e');
      // Handle the error appropriately (e.g., show an error message to the user)
    } finally {
      setState(() {}); // Rebuild the widget after the fetch operation completes
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> availableDates = getAvailableDates();
    return Scaffold(
      backgroundColor: Colors.grey[100], // Set a light background color
      appBar: AppBar(
        elevation: 0, // Remove the app bar shadow
        backgroundColor: Colors.transparent, // Make the app bar transparent
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              const UserGreeting(),
              const SizedBox(height: 16.0),
              if (_bankNames.isEmpty)
                const Text(
                  'No bank is connected.',
                  style: TextStyle(fontSize: 16),
                )
              else
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButton<String>(
                          value: _selectedBank,
                          items: _bankNames.map((bankName) {
                            return DropdownMenuItem<String>(
                              value: bankName,
                              child: Text(bankName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBank = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    BalanceCard(selectedBank: _selectedBank), // Pass the selected bank
                    const SizedBox(height: 16.0),
                    const Text(
                      'Spending by Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (availableDates.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<DateTime>(
                            value: _selectedDate,
                            items: availableDates
                                .map((date) => DropdownMenuItem(
                                      value: date,
                                      child: Text(DateFormat('MMMM yyyy').format(date)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedDate = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    if (availableDates.isEmpty)
                      const Text('No transaction data available'),
                    CategoryPieChart(
                      selectedDate: _selectedDate,
                      selectedBank: _selectedBank,
                    ),
                    const SizedBox(height: 16.0),
                    TransactionsHeader(
                      onViewAllPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionsScreen(transactions: myTransactionData),
                          ),
                        );
                      },
                    ),
                    TransactionsList(
                      transactions: _selectedBank == 'All'
                          ? myTransactionData.take(5).toList()
                          : myTransactionData
                              .where((transaction) => transaction['bank'] == _selectedBank)
                              .take(5)
                              .toList(),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryPieChart extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedBank;

  const CategoryPieChart({
    super.key,
    required this.selectedDate,
    required this.selectedBank,
  });

  @override
  _CategoryPieChartState createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> {
  List<PieChartSectionData>? getCategoryTotals(DateTime selectedDate, String selectedBank) {
    Map<String, double> categoryTotals = {};

    print('Selected Bank: $selectedBank'); // Debug: Print the selected bank

    List<Map<String, dynamic>> filteredTransactions = [];
    for (var transaction in myTransactionData) {
      DateTime transactionDate = DateFormat('dd/MM/yyyy').parse(transaction['date']);
      if (transactionDate.year == selectedDate.year &&
          transactionDate.month == selectedDate.month &&
          (selectedBank == 'All' || transaction['bank'] == selectedBank)) {
        filteredTransactions.add(transaction);
        String category = transaction['name'];
        double amount = double.parse(transaction['totalAmount'].replaceAll('£', ''));
        if (categoryTotals.containsKey(category)) {
          categoryTotals[category] = categoryTotals[category]! + amount;
        } else {
          categoryTotals[category] = amount;
        }
      }
    }

    print('Filtered Transactions: $filteredTransactions'); // Debug: Print the filtered transactions

    if (categoryTotals.isEmpty) {
      return null;
    }

    double totalSpending = categoryTotals.values.fold(0, (sum, amount) => sum + amount);
    double radiusFactor = totalSpending < 100 ? 1.5 : 1.0; // Adjust the threshold as needed

    List<PieChartSectionData> sections = [];
    categoryTotals.forEach((category, total) {
      sections.add(
        PieChartSectionData(
          value: total,
          color: myTransactionData.firstWhere((tx) => tx['name'] == category)['color'],
          title: '£${total.toStringAsFixed(2)}',
          radius: 80 * radiusFactor,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          badgeWidget: FaIcon(
            myTransactionData.firstWhere((tx) => tx['name'] == category)['icon'].icon,
            color: Colors.black,
            size: 20,
          ),
          badgePositionPercentageOffset: .98,
        ),
      );
    });
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData>? sections =
        getCategoryTotals(widget.selectedDate, widget.selectedBank);

    double totalSpending = sections?.reduce((value, element) => PieChartSectionData(
          value: value.value + element.value,
        )).value ??
        0.0;

    double sectionsSpace = totalSpending < 100 ? 4 : 2; // Adjust the threshold and values as needed
    double centerSpaceRadius = totalSpending < 100 ? 40 : 60; // Adjust the threshold and values as needed

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 350,
        child: sections == null || sections.isEmpty
            ? const Center(
                child: Text(
                  'No data available for the selected bank and date.',
                  textAlign: TextAlign.center,
                ),
              )
            : PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: sectionsSpace,
                  centerSpaceRadius: centerSpaceRadius,
                  borderData: FlBorderData(show: false),
                ),
              ),
      ),
    );
  }
}