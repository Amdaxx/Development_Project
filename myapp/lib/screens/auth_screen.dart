import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectx/screens/passcode_screen.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredName = '';
  int _enteredAge = 0;
  String _enteredPhone = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    try {
      if (_isLogin) {
        // Log in
        await _firebaseAuth.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        // Sign up
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        // New user created, now adding a document for the user in Firestore
        final userId = userCredential.user!.uid; // Getting the user's UID
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'name': _enteredName,
          'age': _enteredAge,
          'phone': _enteredPhone,
          'accessToken': '',
          'passcode': '', // Initialize the passcode field
        });

        // Navigate to the PasscodeScreen
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const PasscodeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message ?? 'Authentication failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/icon.webp'),
                //webp
              ),
              Card(
                margin: const EdgeInsets.all(20),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            style: const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if (!_isLogin) ...[
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your name.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredName = value!;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Age',
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || int.tryParse(value) == null || int.parse(value) < 0) {
                                  return 'Please enter a valid age.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredAge = int.parse(value!);
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty || value.length != 10) {
                                  return 'Please enter a valid 10-digit phone number.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPhone = value!;
                              },
                            ),
                          ],
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? 'Create Account'
                                  : 'I already have an account. Login',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          if (_isLogin)
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}