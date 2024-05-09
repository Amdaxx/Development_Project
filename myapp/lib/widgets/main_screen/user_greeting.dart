import 'package:flutter/material.dart';
import 'package:projectx/widgets/main_screen/user_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserGreeting extends StatefulWidget {
  const UserGreeting({super.key});

  @override
  _UserGreetingState createState() => _UserGreetingState();
}

class _UserGreetingState extends State<UserGreeting> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _getUserNameFromFirebase();
  }

  Future<void> _getUserNameFromFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data();
          if (data != null && data.containsKey('name')) {
            setState(() {
              userName = data['name'];
            });
          }
        }
      }
    } catch (e) {
      print('Error getting user name from Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          UserIcon(),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            Text(
              userName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ],
    );
  }
}