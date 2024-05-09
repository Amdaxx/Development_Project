import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectx/screens/exscreen.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({super.key});

  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  final _passkeyController = TextEditingController();
  bool _isPasscodeSet = false;

  @override
  void initState() {
    super.initState();
    _checkPasscode();
  }

  @override
  void dispose() {
    _passkeyController.dispose();
    super.dispose();
  }

  void _checkPasscode() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists && userDoc.data()!.containsKey('passcode')) {
          final storedPasscode = userDoc.data()!['passcode'];
          if (storedPasscode.isNotEmpty) {
            setState(() {
              _isPasscodeSet = true;
            });
          }
        }
      }
    } catch (e) {
      print('Error checking passcode: $e');
    }
  }

  void _setPasscode() async {
    if (_passkeyController.text.trim().length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid 4-digit passcode.'),
        ),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'passcode': _passkeyController.text.trim()});
        setState(() {
          _isPasscodeSet = true;
        });
        // Navigate to the HomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const ExScreen(),
          ),
        );
      }
    } catch (e) {
      print('Error setting passcode: $e');
    }
  }

  void _validatePasscode() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists && userDoc.data()!.containsKey('passcode')) {
          final storedPasscode = userDoc.data()!['passcode'];
          if (storedPasscode == _passkeyController.text.trim()) {
            // Passcode validation successful, navigate to the HomeScreen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ExScreen(),
              ),
            );
          } else {
            // Invalid passcode, show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid passcode. Please try again.'),
              ),
            );
          }
        } else {
          // No passcode set, navigate to the HomeScreen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const ExScreen(),
            ),
          );
        }
      }
    } catch (e) {
      print('Error validating passcode: $e');
    }
  }

  void _forgotPasscode() {
    // TODO: Implement forgot passcode logic
    // You can show a dialog or navigate to a forgot passcode screen
    // where the user can reset their passcode
    print('Forgot Passcode clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passcode'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey.shade800],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter Passcode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: _passkeyController,
                  decoration: InputDecoration(
                    labelText: 'Passcode',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isPasscodeSet ? _validatePasscode : _setPasscode,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: Text(
                    _isPasscodeSet ? 'Verify Passcode' : 'Set Passcode',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: _forgotPasscode,
                  child: Text(
                    'Forgot Passcode?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}