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
      backgroundColor: Colors.white, // Changed to white background
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, -5)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF38E54D), // Green accent color
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 10),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex == 0
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.home_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.home, size: 24),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex == 1
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.code_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.code, size: 24),
                ),
                label: 'Developers',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex == 2
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.work_outline, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.work, size: 24),
                ),
                label: 'Projects',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex == 3
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.people_outline, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.people, size: 24),
                ),
                label: 'Clients',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex == 4
                        ? Color(0xFF38E54D).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Icon(Icons.settings_outlined, size: 24),
                ),
                activeIcon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF38E54D).withOpacity(0.2),
                  ),
                  child: Icon(Icons.settings, size: 24),
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}