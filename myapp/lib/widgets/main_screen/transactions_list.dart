import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, int i) {
        final transaction = transactions[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TransactionIcon(
                        color: transaction['color'] ?? Colors.grey,
                        icon: transaction['icon'] ?? const Icon(Icons.error),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction['transaction'] ?? 'Unknown Transaction',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            transaction['bank'] ?? 'Unknown Bank',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        transaction['totalAmount'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        transaction['date'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TransactionIcon extends StatelessWidget {
  final Color color;
  final Widget icon;

  const TransactionIcon({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        icon,
      ],
    );
  }
}