import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceCard extends StatelessWidget {
  final String selectedBank;

  const BalanceCard({super.key, required this.selectedBank});

  Future<Map<String, dynamic>> fetchBankBalanceData(String bankName) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = snapshot.data();

      if (bankName == 'All') {
        return {
          'balance': data?['Balance'] ?? '0',
          'income': data?['Income'] ?? '0',
          'expense': data?['Expense'] ?? '0',
        };
      } else {
        return {
          'balance': data?['Balance${bankName.split(' ').last}'] ?? '0',
          'income': data?['Income${bankName.split(' ').last}'] ?? '0',
          'expense': data?['Expense${bankName.split(' ').last}'] ?? '0',
        };
      }
    } else {
      print('No user is currently signed in.');
      return {
        'balance': '0',
        'income': '0',
        'expense': '0',
      };
    }
  } catch (e) {
    print('Error fetching bank balance data: $e');
    return {
      'balance': '0',
      'income': '0',
      'expense': '0',
    };
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchBankBalanceData(selectedBank),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final data = snapshot.data!;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                transform: const GradientRotation(pi / 4),
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.shade400,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '£${data['balance']}',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      BalanceItem(
                        icon: CupertinoIcons.arrow_up,
                        color: Colors.greenAccent,
                        title: "Income",
                        amount: data['income'],
                      ),
                      const Spacer(),
                      BalanceItem(
                        icon: CupertinoIcons.arrow_down,
                        color: Colors.redAccent,
                        title: "Expense",
                        amount: data['expense'],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class BalanceItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String amount;

  const BalanceItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            color: Colors.white30,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 12,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '£$amount',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}