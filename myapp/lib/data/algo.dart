import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> analyzeSpendingHabits(List<Map<String, dynamic>> transactionData) async {
  // Step 1: Group transactions by month
  Map<String, List<Map<String, dynamic>>> transactionsByMonth = {};
  for (var transaction in transactionData) {
    String month = transaction['date'].substring(3); // Extract month from date
    transactionsByMonth.putIfAbsent(month, () => []).add(transaction);
  }

  // Step 2: Calculate total spending for each month
  Map<String, double> totalSpendingByMonth = {};
  transactionsByMonth.forEach((month, transactions) {
    double totalSpending = transactions.fold(
      0,
      (sum, transaction) => sum + double.parse(transaction['totalAmount'].substring(1)),
    );
    totalSpendingByMonth[month] = totalSpending;
  });

  // Step 3: Categorize transactions
  Map<String, Map<String, double>> spendingByCategory = {};
  transactionsByMonth.forEach((month, transactions) {
    spendingByCategory[month] = {};
    for (var transaction in transactions) {
      String category = transaction['name'];
      double amount = double.parse(transaction['totalAmount'].substring(1));
      spendingByCategory[month]![category] =
          (spendingByCategory[month]![category] ?? 0) + amount;
    }
  });

  // Step 4: Analyze spending habits
  Map<String, List<String>> topCategoriesByMonth = {};
  spendingByCategory.forEach((month, categories) {
    List<MapEntry<String, double>> categoryEntries = categories.entries.toList();
    categoryEntries.sort((a, b) => b.value.compareTo(a.value));
    List<String> topCategories = categoryEntries
        .take(3)
        .map((entry) => entry.key)
        .toList();
    topCategoriesByMonth[month] = topCategories;
  });

  // Step 5: Write the analyzed data to Firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference spendingCollection = firestore.collection('spending');

  await spendingCollection.doc('analysis').set({
    'totalSpendingByMonth': totalSpendingByMonth,
    'spendingByCategory': spendingByCategory,
    'topCategoriesByMonth': topCategoriesByMonth,
  });

  print('Spending analysis data written to Firebase.');
}