import 'package:projectx/screens/budgeting_plan.dart';
import 'package:projectx/screens/educational_screen.dart';
import 'package:projectx/screens/portfolio_screen.dart';
import 'package:projectx/screens/setting_screen.dart';
import 'package:projectx/screens/main_screen.dart';
import 'package:projectx/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ExScreen extends StatefulWidget {
  const ExScreen({super.key});

  @override
  _ExScreenState createState() => _ExScreenState();
}

class _ExScreenState extends State<ExScreen> {
  final List<Widget> _screens = [
    
    const MainScreen(),
    PortfolioScreen(),
    BudgetScreen(),
    const EducationResourcesPage(),
    const SettingsScreen(),
    // Add more screens as needed
  ];

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(onItemTapped: _onItemTapped),
      /*
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      */
    );
  }
}