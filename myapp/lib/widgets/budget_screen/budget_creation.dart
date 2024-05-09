import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BudgetCreationScreen extends StatefulWidget {
  final Function(
    double,
    double,
    double,
    double,
    double,
    double,
    double,
    bool,
    double,
    bool,
    double,
  ) onBudgetCreated;

  BudgetCreationScreen({required this.onBudgetCreated});

  @override
  _BudgetCreationScreenState createState() => _BudgetCreationScreenState();
}

class _BudgetCreationScreenState extends State<BudgetCreationScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Budget Plan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField(
                icon: FontAwesomeIcons.moneyBillAlt,
                labelText: 'Bills',
                onChanged: (value) {
                  setState(() {
                    _billsAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              _buildInputField(
                icon: FontAwesomeIcons.shoppingCart,
                labelText: 'Food',
                onChanged: (value) {
                  setState(() {
                    _foodAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              _buildInputField(
                icon: FontAwesomeIcons.utensils,
                labelText: 'Eat Out',
                onChanged: (value) {
                  setState(() {
                    _eatOutAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              _buildInputField(
                icon: FontAwesomeIcons.tv,
                labelText: 'Entertainment',
                onChanged: (value) {
                  setState(() {
                    _entertainmentAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              _buildInputField(
                icon: FontAwesomeIcons.shoppingBag,
                labelText: 'Shopping',
                onChanged: (value) {
                  setState(() {
                    _shoppingAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              _buildInputField(
                icon: FontAwesomeIcons.home,
                labelText: 'Mortgage',
                onChanged: (value) {
                  setState(() {
                    _mortgageAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              _buildInputField(
                icon: FontAwesomeIcons.car,
                labelText: 'Transport',
                onChanged: (value) {
                  setState(() {
                    _transportAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Investments', style: TextStyle(color: Colors.black54)),
                value: _hasInvestments,
                onChanged: (value) {
                  setState(() {
                    _hasInvestments = value;
                  });
                },
                secondary: Icon(FontAwesomeIcons.moneyBillAlt, color: Colors.black54),
              ),
              if (_hasInvestments)
                _buildInputField(
                  icon: FontAwesomeIcons.moneyBillAlt,
                  labelText: 'Investments Amount',
                  onChanged: (value) {
                    setState(() {
                      _investmentsAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              SwitchListTile(
                title: Text('Rent', style: TextStyle(color: Colors.black54)),
                value: _hasRent,
                onChanged: (value) {
                  setState(() {
                    _hasRent = value;
                  });
                },
                secondary: Icon(FontAwesomeIcons.home, color: Colors.black54),
              ),
              if (_hasRent)
                _buildInputField(
                  icon: FontAwesomeIcons.home,
                  labelText: 'Rent Amount',
                  onChanged: (value) {
                    setState(() {
                      _rentAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                child: Text(
                  'Create Budget',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  widget.onBudgetCreated(
                    _billsAmount,
                    _foodAmount,
                    _eatOutAmount,
                    _entertainmentAmount,
                    _shoppingAmount,
                    _mortgageAmount,
                    _transportAmount,
                    _hasInvestments,
                    _investmentsAmount,
                    _hasRent,
                    _rentAmount,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          prefixIcon: Icon(icon, color: Colors.black54),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}