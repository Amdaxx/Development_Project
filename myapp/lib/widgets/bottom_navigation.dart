import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int) onItemTapped;

  const BottomNavigation({super.key, required this.onItemTapped});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed, // Set the type to fixed
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.graph_square_fill),
          label: 'Portfolio',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.money_pound_circle_fill),
          label: 'Budget',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book_circle_fill),
          label: 'Education',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
        // Add more navigation items as needed
      ],
    );
  }
}