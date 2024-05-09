import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectx/widgets/budget_screen/budget_creation.dart';
import 'package:projectx/widgets/budget_screen/budget_graph.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  bool _hasBudget = false;
  double _budgetAmount = 0.0;
  double _totalSpending = 0.0;
  double _billsAmount = 0.0;
  double _foodAmount = 0.0;
  double _eatOutAmount = 0.0;
  double _entertainmentAmount = 0.0;
  double _shoppingAmount = 0.0;
  double _mortgageAmount = 0.0;
  double _transportAmount = 0.0;
  bool _hasInvestments = false;
  double _investmentsAmount = 0.0;
  bool _hasRent = false;
  double _rentAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _checkBudgetInFirestore();
  }

  Future<void> _checkBudgetInFirestore() async {
    final user = _auth.currentUser;
    if (user != null) {
      final budgetRef = _firestore.collection('budget').doc(user.uid);
      final budgetSnapshot = await budgetRef.get();
      if (budgetSnapshot.exists) {
        final data = budgetSnapshot.data();
        setState(() {
          _hasBudget = true;
          _billsAmount = data?['billsAmount'] ?? 0.0;
          _foodAmount = data?['foodAmount'] ?? 0.0;
          _eatOutAmount = data?['eatOutAmount'] ?? 0.0;
          _entertainmentAmount = data?['entertainmentAmount'] ?? 0.0;
          _shoppingAmount = data?['shoppingAmount'] ?? 0.0;
          _mortgageAmount = data?['mortgageAmount'] ?? 0.0;
          _transportAmount = data?['transportAmount'] ?? 0.0;
          _hasInvestments = data?['hasInvestments'] ?? false;
          _investmentsAmount = data?['investmentsAmount'] ?? 0.0;
          _hasRent = data?['hasRent'] ?? false;
          _rentAmount = data?['rentAmount'] ?? 0.0;
          _budgetAmount = _billsAmount +
              _foodAmount +
              _eatOutAmount +
              _entertainmentAmount +
              _shoppingAmount +
              _mortgageAmount +
              _transportAmount +
              (_hasInvestments ? _investmentsAmount : 0) +
              (_hasRent ? _rentAmount : 0);
        });
      }
    }
  }

  Future<void> _createBudget(BuildContext context) async {
    final user = _auth.currentUser;
    if (user != null) {
      final budgetRef = _firestore.collection('budget').doc(user.uid);
      await budgetRef.set({
        'billsAmount': _billsAmount,
        'foodAmount': _foodAmount,
        'eatOutAmount': _eatOutAmount,
        'entertainmentAmount': _entertainmentAmount,
        'shoppingAmount': _shoppingAmount,
        'mortgageAmount': _mortgageAmount,
        'transportAmount': _transportAmount,
        'hasInvestments': _hasInvestments,
        'investmentsAmount': _investmentsAmount,
        'hasRent': _hasRent,
        'rentAmount': _rentAmount,
      });
      setState(() {
        _hasBudget = true;
      });
    }
  }

  Future<void> _showBudgetCreationDialog(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BudgetCreationScreen(
          onBudgetCreated: (
            billsAmount,
            foodAmount,
            eatOutAmount,
            entertainmentAmount,
            shoppingAmount,
            mortgageAmount,
            transportAmount,
            hasInvestments,
            investmentsAmount,
            hasRent,
            rentAmount,
          ) {
            setState(() {
              _billsAmount = billsAmount;
              _foodAmount = foodAmount;
              _eatOutAmount = eatOutAmount;
              _entertainmentAmount = entertainmentAmount;
              _shoppingAmount = shoppingAmount;
              _mortgageAmount = mortgageAmount;
              _transportAmount = transportAmount;
              _hasInvestments = hasInvestments;
              _investmentsAmount = investmentsAmount;
              _hasRent = hasRent;
              _rentAmount = rentAmount;
              _budgetAmount = billsAmount +
                  foodAmount +
                  eatOutAmount +
                  entertainmentAmount +
                  shoppingAmount +
                  mortgageAmount +
                  transportAmount +
                  (_hasInvestments ? investmentsAmount : 0) +
                  (_hasRent ? rentAmount : 0);
              _hasBudget = true;
            });
            _createBudget(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Screen'),
      ),
      body: _hasBudget
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Budget',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '\£${_budgetAmount.toStringAsFixed(2)}',
                              style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  BudgetChart(
                    budgetAmount: _budgetAmount,
                    totalSpending: _totalSpending,
                    mortgageAmount: _mortgageAmount,
                    foodAmount: _foodAmount,
                    eatOutAmount: _eatOutAmount,
                    entertainmentAmount: _entertainmentAmount,
                    shoppingAmount: _shoppingAmount,
                    transportAmount: _transportAmount,
                    investmentsAmount: _investmentsAmount,
                    rentAmount: _rentAmount,
                    userId: 'IdSFBLMQDMQy9j3YICn4uuaWXZg2',
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You haven\'t created a budget plan yet.'),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Text('Create Budget Plan'),
                    onPressed: () {
                      _showBudgetCreationDialog(context);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}