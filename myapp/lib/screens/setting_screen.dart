import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectx/screens/auth_screen.dart';
import 'package:projectx/screens/linkedbanks_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the AuthScreen after successful logout
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthScreen()),
        (route) => false,
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingCard(
                    context,
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () {
                      // Navigate to change password screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  _buildSettingCard(
                    context,
                    icon: Icons.pin,
                    title: 'Update PIN',
                    onTap: () {
                      // Navigate to update PIN screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  _buildSettingCard(
                    context,
                    icon: Icons.notifications,
                    title: 'Notification Settings',
                    onTap: () {
                      // Navigate to notification settings screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  _buildSettingCard(
                    context,
                    icon: Icons.link,
                    title: 'Link Bank',
                    onTap: () {
                      // Navigate to the link bank screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LinkedBanksPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 12.0),
                  _buildSettingCard(
                    context,
                    icon: Icons.logout,
                    title: 'Log Out',
                    onTap: _logout,
                    isLogoutButton: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogoutButton = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isLogoutButton)
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.0),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  // Implement change password screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: const Center(
        child: Text('Change Password Screen'),
      ),
    );
  }
}