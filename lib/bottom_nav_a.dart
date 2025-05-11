import 'dart:ui';
import 'package:flutter/material.dart';
import 'developer_home.dart';
import 'developer_page.dart';
import 'projects_page_a.dart';
import 'clients_page.dart';
import 'settings_page_A.dart';

class BottomNav_A extends StatefulWidget {
  @override
  _BottomNav_AState createState() => _BottomNav_AState();
}

class _BottomNav_AState extends State<BottomNav_A> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DeveloperHomePage(),
    DeveloperPage(),
    ProjectsPage(),
    ClientsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B10), // Dark green background
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF133A1B), // Zucchini green
          border: Border(
            top: BorderSide(color: Color(0xFF011B10), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.greenAccent, // Futuristic green
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Orbitron',
            fontSize: 12,
            letterSpacing: 1.0,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 11,
            letterSpacing: 1.0,
          ),
          items: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.code, 'Developers', 1),
            _buildNavItem(Icons.work, 'Projects', 2),
            _buildNavItem(Icons.people, 'Clients', 3),
            _buildNavItem(Icons.settings, 'Settings', 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Icon(
          icon,
          size: isSelected ? 26 : 22,
          shadows: isSelected
              ? [
            Shadow(
              blurRadius: 10,
              color: Colors.greenAccent,
              offset: Offset(0, 0),
            )
          ]
              : [],
        ),
      ),
      label: label,
    );
  }
}
