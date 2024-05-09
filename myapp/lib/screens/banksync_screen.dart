import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectx/data/transactions.dart';



Future<void> authenticateUserWithTrueLayer(BuildContext context) async {
 
  const String authUrl = 'https://auth.truelayer-sandbox.com/?response_type=code&client_id=sandbox-adel-02f095&scope=info%20accounts%20balance%20cards%20transactions%20direct_debits%20standing_orders%20offline_access&redirect_uri=https://console.truelayer.com/redirect-page&providers=uk-cs-mock%20uk-ob-all%20uk-oauth-all';

  if (await canLaunch(authUrl)) {
    await launch(authUrl);
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;

      await updateUserBankAccount(userId);
    } else {
     
    }
  } else {
    throw 'Could not launch $authUrl';
  }
}


//
//
//

Future<void> updateUserBankAccount(String userId) async {
  
  try {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userDocRef.get();
    final currentNooBanks = userSnapshot.data()?['nooBanks'] ?? 0;
    final newAccessToken = "Mock Bank ${currentNooBanks + 1}";

    await userDocRef.update({
      'nooBanks': FieldValue.increment(1),
      'accessToken': FieldValue.arrayUnion([newAccessToken])
    });

   

    // Store transaction data based on the number of linked banks
    if (currentNooBanks == 0) {
      // User has no bank account linked, store Mock Bank 1 transactions
      await storeTransactionData(userId, 'Mock Bank 1');
    } else {
      // User already has a bank linked, store Mock Bank 2 transactions
      await storeTransactionData(userId, 'Mock Bank 2');
    }
  } catch (e) {
    
  }
}

Future<void> storeTransactionData(String userId, String bankName) async {
  
  try {
    final transactionCollection = FirebaseFirestore.instance.collection('transactions');

    // Filter the transaction data based on the bank name
    final bankTransactions = myTransactionData.where((transaction) => transaction['bank'] == bankName).toList();

    // Store each transaction document in Firestore
    for (final transaction in bankTransactions) {
      await transactionCollection.add({
        'userId': userId,
        'icon': transaction['icon'].toString(),
        'color': transaction['color'].toString(),
        'name': transaction['name'],
        'totalAmount': transaction['totalAmount'],
        'date': transaction['date'],
        'transaction': transaction['transaction'],
        'bank': transaction['bank'],
      });
    }

   
  } catch (e) {
   
  }
}