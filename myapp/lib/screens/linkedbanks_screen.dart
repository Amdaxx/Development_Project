import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectx/screens/banksync_screen.dart';

class LinkedBanksPage extends StatefulWidget {
  @override
  _LinkedBanksPageState createState() => _LinkedBanksPageState();
}

class _LinkedBanksPageState extends State<LinkedBanksPage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Linked Bank Accounts'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>?;
          final noOfBanks = userData?['nooBanks'] ?? 0;
          final accessTokens = List<String>.from(userData?['accessToken'] ?? []);

          return Column(
            children: [
              if (noOfBanks > 0)
                Expanded(
                  child: ListView.builder(
                    itemCount: noOfBanks,
                    itemBuilder: (context, index) {
                      final accessToken = accessTokens.length > index
                          ? accessTokens[index]
                          : 'Access Token Not Available';

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.account_balance),
                          title: Text(
                            'Bank Account ${index + 1}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Bank Name: $accessToken',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _unlinkBankAccount(index, accessTokens);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text(
                      'No linked bank accounts',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: _addBankAccount,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add Bank Account',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _unlinkBankAccount(int index, List<String> accessTokens) async {
    final updatedAccessTokens = [...accessTokens];
    updatedAccessTokens.removeAt(index);

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'accessToken': updatedAccessTokens,
      'nooBanks': updatedAccessTokens.length,
    });
  }

  Future<void> _addBankAccount() async {
    await authenticateUserWithTrueLayer(context);
  }
}