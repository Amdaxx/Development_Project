import 'package:flutter/material.dart';

class TransactionsHeader extends StatelessWidget {
  final VoidCallback onViewAllPressed;

  const TransactionsHeader({super.key, required this.onViewAllPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Transactions",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onViewAllPressed,
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}